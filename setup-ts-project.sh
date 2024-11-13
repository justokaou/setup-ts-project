#!/bin/bash
# Define color variables for output formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Exit the script on any error
set -e

# Function to display usage/help message
usage() {
    echo "Usage: $0 [-h|--help] [-d|--directory <directory_path>] [-p|--package-manager <npm|yarn>] [-l|--libraries <libraries>] [-c|--create-structure] [-g|--git] [-w|--webapp]"
    echo "  -h, --help                  Display this help message"
    echo "  -d, --directory             Path to the directory where the TypeScript project will be created."
    echo "  -p, --package-manager       Package manager to use (npm or yarn). Default is npm."
    echo "  -l, --libraries             Space-separated list of additional libraries to install."
    echo "  -c, --create-structure      Create the basic project structure (src/index.ts)"
    echo "  -g, --git                   Initialize Git and create a .gitignore file"
    echo "  -w, --webapp                Create a React TypeScript web application"
    exit 1
}

install_libraries() {
    echo -e "${YELLOW}Installing additional libraries: $libraries${NC}"
    if [[ "$package_manager" == "npm" ]]; then
        npm install $libraries
    elif [[ "$package_manager" == "yarn" ]]; then
        yarn add $libraries
    fi
}

# Initialize variables with default values
directory=""
package_manager="npm"  # Default to npm
libraries=""
webapp=false

# Display usage if no arguments are provided
if [[ $# -eq 0 ]]; then
    usage
fi

# Parse command-line arguments and handle errors for missing values
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--help) usage ;;
        -d|--directory)
            # Check if the next argument is a value and not another option
            if [[ -z "$2" || "$2" =~ ^- ]]; then
                echo -e "${RED}Error: Option $1 requires a value.${NC}"
                usage
            fi
            directory="$2"
            shift
            ;;
        -p|--package-manager)
            # Ensure the package manager option has a value
            if [[ -z "$2" || "$2" =~ ^- ]]; then
                echo -e "${RED}Error: Option $1 requires a value.${NC}"
                usage
            fi
            package_manager="$2"
            shift
            ;;
        -l|--libraries)
            # Validate that the libraries option is followed by a value
            if [[ -z "$2" || "$2" =~ ^- ]]; then
                echo -e "${RED}Error: Option $1 requires a value.${NC}"
                usage
            fi
            libraries="$2"
            shift
            ;;
        -c|--create-structure) create_structure=true ;;  # Flag for creating basic structure
        -g|--git) git=true ;;  # Flag for Git initialization
        -w|--webapp) webapp=true ;;  # Flag for creating a React TypeScript webapp
        *)
            echo -e "${RED}Error: Invalid option $1${NC}"
            usage
            ;;
    esac
    shift
done

# Check if npm, yarn, and git are installed before proceeding
echo -e "${CYAN}Checking if all required tools are installed...${NC}"

# Check if the specified package manager is installed
if [[ "$package_manager" == "npm" ]]; then
    echo -e "${CYAN}Checking if npm is installed...${NC}"
    command -v npm >/dev/null 2>&1 || { echo -e "${RED}Error: npm is not installed. Please install it.${NC}"; exit 1; }
    # Check for npx if webapp option is selected
    if [[ "$webapp" == "true" ]]; then
        echo -e "${CYAN}Checking if npx is installed...${NC}"
        command -v npx >/dev/null 2>&1 || { echo -e "${RED}Error: npx is not installed. Please install it or update npm.${NC}"; exit 1; }
    fi
elif [[ "$package_manager" == "yarn" ]]; then
    echo -e "${CYAN}Checking if yarn is installed...${NC}"
    command -v yarn >/dev/null 2>&1 || { echo -e "${RED}Error: yarn is not installed. Please install it.${NC}"; exit 1; }
fi

# Check if git is installed if the git option is selected
if [[ "$git" == "true" ]]; then
    echo -e "${CYAN}Checking if git is installed...${NC}"
    command -v git >/dev/null 2>&1 || { echo -e "${RED}Error: git is not installed. Please install it.${NC}"; exit 1; }
fi

# Validate the directory option
if [[ -z "$directory" ]]; then
    echo -e "${RED}Error: You need to specify a directory.${NC}"
    usage
fi

# Check if dir name is valid
if [[ ! "$directory" =~ ^[a-zA-Z0-9._-]+$ ]]; then
    echo -e "${RED}Error: Directory name contains invalid characters.${NC}"
    exit 1
fi

# Validate the package manager option
if [[ "$package_manager" != "npm" && "$package_manager" != "yarn" ]]; then
    echo -e "${RED}Error: Invalid package manager. Choose 'npm' or 'yarn'.${NC}"
    exit 1
fi

# Create the directory if it does not exist
if [[ ! -d "$directory" ]]; then
    echo -e "${YELLOW}Directory does not exist. It will be created.${NC}"
    mkdir -p "$directory"
fi

# Navigate to the project directory
cd "$directory" || exit

if [[ "$webapp" == "true" ]]; then
    echo -e "${CYAN}Creating a React TypeScript web application...${NC}"
    if [[ "$package_manager" == "npm" ]]; then
        npx create-react-app . --template typescript
    elif [[ "$package_manager" == "yarn" ]]; then
        yarn create react-app . --template typescript
    fi
    # Install additional libraries if specified
    if [[ -n "$libraries" ]]; then
        install_libraries
    fi
else
    # Handle TypeScript project creation (without React)
    echo -e "${BLUE}Creating TypeScript project in: $(pwd)${NC}"
    echo -e "${BLUE}Using package manager: $package_manager${NC}"

    echo -e "${CYAN}Initializing TypeScript project...${NC}"
    if [[ "$package_manager" == "npm" ]]; then
        npm init -y
        npm install typescript --save-dev
        npx tsc --init
    elif [[ "$package_manager" == "yarn" ]]; then
        yarn init -y
        yarn add typescript --dev
        yarn tsc --init
    fi
    # Install additional libraries if specified
    if [[ -n "$libraries" ]]; then
        install_libraries
    fi
    # Create basic project structure if the flag is set
    if [[ "$create_structure" == "true" ]]; then
        echo -e "${CYAN}Creating project structure...${NC}"
        mkdir -p src
        touch ./src/index.ts
        echo -e "${CYAN}Configuring tsconfig.json...${NC}"
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
fi


# Initialize Git repository and create .gitignore if the flag is set
if [[ "$git" == "true" ]]; then
    echo -e "${CYAN}Initializing Git and creating .gitignore file...${NC}"
    git init
    cat > .gitignore <<EOF
node_modules
.env
dist
build
EOF
    echo -e "${CYAN}.gitignore file created.${NC}"
else
    echo -e "${YELLOW}.gitignore already exists. Skipping creation.${NC}"
fi


# Display success message
if [[ "$webapp" == "true" ]]; then
    echo -e "${GREEN}React TypeScript web application successfully created in $(pwd). Happy coding!${NC}"
else
    echo -e "${GREEN}TypeScript project successfully created in $(pwd). Happy coding!${NC}"
fi
