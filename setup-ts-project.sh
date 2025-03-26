#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Stop on error
set -e

# Help message
usage() {
    echo "Usage: $0 [-d <directory>] [-p <package-manager>] [-l <libraries>] [-c] [-g] [-w <webapp>]"
    echo "  -h, --help                Show help"
    echo "  -d, --directory           Target directory for the project"
    echo "  -p, --package-manager     Package manager (npm, yarn, pnpm, bun)"
    echo "  -l, --libraries           Space-separated list of libraries to install"
    echo "  -c, --create-structure    Create src/index.ts with tsconfig"
    echo "  -g, --git                 Init Git & .gitignore"
    echo "  -w, --webapp              Webapp template (vite, cra, next)"
    exit 1
}

# Defaults
directory=""
package_manager="npm"
libraries=()
create_structure=false
git=false
webapp=""

# Parse args
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--help) usage ;;
        -d|--directory)
            [[ -z "$2" || "$2" =~ ^- ]] && { echo -e "${RED}Missing value for $1${NC}"; usage; }
            directory="$2"; shift ;;
        -p|--package-manager)
            [[ -z "$2" || "$2" =~ ^- ]] && { echo -e "${RED}Missing value for $1${NC}"; usage; }
            package_manager="$2"; shift ;;
        -l|--libraries)
            shift
            while [[ "$1" && "$1" != -* ]]; do
                libraries+=("$1")
                shift
            done
            continue
            ;;
        -c|--create-structure) create_structure=true ;;
        -g|--git) git=true ;;
        -w|--webapp)
            [[ -z "$2" || "$2" =~ ^- ]] && { echo -e "${RED}Missing value for $1${NC}"; usage; }
            webapp="$2"; shift ;;
        *) echo -e "${RED}Unknown option $1${NC}"; usage ;;
    esac
    shift
done

# Normalize webapp
if [[ -n "$webapp" ]]; then
    case "$webapp" in
        cra|create-react-app) webapp="create-react-app" ;;
        vite|create-vite) webapp="create-vite" ;;
        next|create-next-app) webapp="create-next-app" ;;
        *) echo -e "${RED}Unknown webapp '$webapp'. Try: vite, cra, next.${NC}"; exit 1 ;;
    esac
fi

# Check directory
if [[ -z "$directory" ]]; then
    echo -e "${RED}You must specify a directory (-d).${NC}"
    usage
fi

# Validate directory name
dir_name=$(basename "$directory")
[[ ! "$dir_name" =~ ^[a-zA-Z0-9._-]+$ ]] && { echo -e "${RED}Invalid directory name: $dir_name${NC}"; exit 1; }

# Check package manager installed
if ! command -v "$package_manager" >/dev/null 2>&1; then
    echo -e "${RED}Error: '$package_manager' is not installed.${NC}"
    exit 1
fi

# --- Functions ---
install_libraries() {
    if [[ ${#libraries[@]} -gt 0 ]]; then
        echo -e "${YELLOW}Installing libraries: ${libraries[*]}${NC}"
        case "$package_manager" in
            npm|pnpm) $package_manager install "${libraries[@]}" ;;
            yarn) yarn add "${libraries[@]}" ;;
            bun) bun add "${libraries[@]}" ;;
            *) echo -e "${RED}Unsupported package manager for libs.${NC}"; exit 1 ;;
        esac
    fi
}

install_typescript() {
    echo -e "${CYAN}Installing TypeScript...${NC}"
    case "$package_manager" in
        npm|pnpm) $package_manager install typescript --save-dev ;;
        yarn) yarn add typescript --dev ;;
        bun) bun add -d typescript ;;
        *) echo -e "${RED}Unsupported package manager for dev deps.${NC}"; exit 1 ;;
    esac
}

run_tsc_init() {
    if command -v npx &>/dev/null; then
        npx tsc --init
    else
        $package_manager exec tsc --init
    fi
}

create_webapp() {
    echo -e "${CYAN}Creating $webapp project in $(dirname "$directory")...${NC}"
    cd "$(dirname "$directory")"

    if [[ "$webapp" == "create-react-app" ]]; then
        if [[ "$package_manager" == "yarn" ]]; then
            yarn create react-app "$dir_name" --template typescript
        else
            npx create-react-app "$dir_name" --template typescript
        fi
    else
        if [[ "$package_manager" == "pnpm" ]]; then
            pnpm create "$webapp" "$dir_name" -- --template react-ts
        elif [[ "$package_manager" == "yarn" ]]; then
            case "$webapp" in
                create-vite) yarn create vite "$dir_name" --template react-ts ;;
                create-next-app) yarn create next-app "$dir_name" --typescript ;;
                *) echo -e "${RED}Unsupported yarn webapp: $webapp${NC}"; exit 1 ;;
            esac
        else
            $package_manager create "$webapp" "$dir_name"
        fi
    fi

    cd "$directory"
}

# --- Webapp or TypeScript setup ---
if [[ -n "$webapp" ]]; then
    create_webapp
    install_libraries
else
    echo -e "${CYAN}Initializing basic TypeScript project...${NC}"
    mkdir -p "$directory"
    cd "$directory"
    $package_manager init -y
    install_typescript
    run_tsc_init

    if [[ "$create_structure" == "true" ]]; then
        echo -e "${CYAN}Creating src/index.ts...${NC}"
        mkdir -p src
        touch src/index.ts
        cat > tsconfig.json <<EOF
{
  "compilerOptions": {
    "target": "ES6",
    "module": "commonjs",
    "rootDir": "src",
    "outDir": "dist",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["src/**/*.ts"],
  "exclude": ["node_modules"]
}
EOF
    fi

    install_libraries
fi

# Git init
if [[ "$git" == "true" ]]; then
    echo -e "${CYAN}Initializing Git...${NC}"
    git init
    cat > .gitignore <<EOF
node_modules
.env
dist
build
EOF
fi

# Done
echo -e "${GREEN}Project setup complete in $(pwd)${NC}"
echo -e "${BLUE}Package Manager: $package_manager${NC}"
[[ -n "$webapp" ]] && echo -e "${BLUE}Webapp Template: $webapp${NC}"
[[ ${#libraries[@]} -gt 0 ]] && echo -e "${BLUE}Installed libs: ${libraries[*]}${NC}"
[[ "$create_structure" == "true" ]] && echo -e "${BLUE}Structure: src/index.ts created${NC}"
[[ "$git" == "true" ]] && echo -e "${BLUE}Git initialized${NC}"