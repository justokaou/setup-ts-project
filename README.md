# 🛠️ setup-ts-project.sh

`setup-ts-project.sh` is a Bash script to quickly set up a **Node.js** project with **TypeScript**.  
It automates project initialization, TypeScript configuration, additional library installation, Git initialization,  
and even supports scaffolding a React/TypeScript web application using tools like Vite or CRA.

---

## 📋 Prerequisites

Ensure that you have the following tools installed on your system:
- **Node.js** (version 14+)
- **npm**, **yarn**, **pnpm**, or **bun**
- **git**

---

## ⚙️ Installation

Clone the repository or download the script directly:

```bash
git clone https://github.com/justokaou/setup-ts-project.git
cd setup-ts-project
chmod +x setup-ts-project.sh
```

---

## 💻 Usage

```bash
./setup-ts-project.sh [-h|--help] [-d|--directory <directory_path>] [-p|--package-manager <npm|yarn|pnpm|bun>] [-l|--libraries <libraries>] [-c|--create-structure] [-g|--git] [-w|--webapp <vite|cra|next>]
```

---

## 🔍 Options

| Option                    | Description                                                        |
|---------------------------|--------------------------------------------------------------------|
| `-h`, `--help`            | Displays help message and available options                        |
| `-d`, `--directory`       | Specifies the directory where the project will be created          |
| `-p`, `--package-manager` | Choose the package manager (`npm`, `yarn`, `pnpm`, `bun`) — default: `npm` |
| `-l`, `--libraries`       | Space-separated list of additional libraries to install            |
| `-c`, `--create-structure`| Creates the basic project structure (`src/index.ts`)             |
| `-g`, `--git`             | Initializes a Git repository and creates a `.gitignore` file      |
| `-w`, `--webapp`          | Scaffold a React/TS app using a tool like `vite`, `cra`, or `next` |

---

## 🛠️ Examples

### Example 1: Initialize a basic TypeScript project with npm

```bash
./setup-ts-project.sh -d my_project -p npm -c -g
```

- Creates a project in the `my_project` directory  
- Uses **npm** as the package manager  
- Creates the basic structure (`src/index.ts`)  
- Initializes a Git repository and adds a `.gitignore` file

---

### Example 2: Create a React/TS web app with Vite using yarn

```bash
./setup-ts-project.sh -d my_webapp -p yarn -w vite -l axios zod -g
```

- Creates a web app using **Vite** and **React TypeScript**
- Uses **yarn** as the package manager
- Installs **axios**, **zod**
- Initializes a Git repository

---

### Example 3: Show help

```bash
./setup-ts-project.sh --help
```

Displays the help message.

---

## 📂 Project Structure

After running the script with the `-c` option for a basic TypeScript project, your project will look like this:

```
my_project/
├── src/
│   └── index.ts
├── tsconfig.json
├── package.json
├── node_modules/
└── .gitignore
```

If you use the `-w` option, the structure depends on the chosen tool (e.g. Vite or CRA).

---

## 🧾 Summary Output

At the end of the script, a **clear summary** is printed with:

- Project location
- Package manager used
- Webapp tool (if any)
- Installed libraries
- Structure creation
- Git initialization status

---

## 📄 .gitignore

The script creates the following entries:

```
node_modules
.env
dist
build
```

---

## ⚠️ Dependency Check

The script validates that the following tools are installed:

- `$package_manager`
- `npx` (for CRA)
- `git` (if `--git` is used)

If any are missing, the script exits with an error message.

---

## 📖 Documentation

- Node.js: https://nodejs.org/
- TypeScript: https://www.typescriptlang.org/docs/
- npm: https://docs.npmjs.com/
- yarn: https://yarnpkg.com/getting-started
- pnpm: https://pnpm.io/
- bun: https://bun.sh/
- React: https://reactjs.org/docs/getting-started.html

---

## 🛡️ License

Licensed under the MIT License. See [LICENSE](LICENSE) for details.

---

## 🤝 Contributions

Contributions are welcome!  
Feel free to open an issue or PR.

---

## ✨ Author

- JustOkaou – https://github.com/justokaou  
See [contributors](https://github.com/justokaou/setup-ts-project/contributors) for more.

---

🎉 Thank you for using `setup-ts-project.sh`! Happy coding 🚀
