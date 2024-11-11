# 🛠️ setup-ts-project.sh

`setup-ts-project.sh` is a Bash script to quickly set up a **Node.js** project with **TypeScript**. It automates project initialization, TypeScript configuration, additional library installation, and Git initialization. It also supports creating a React TypeScript web application.

## 📋 Prerequisites

Ensure that you have the following tools installed on your system:
- **Node.js** (version 14+)
- **npm** or **yarn**
- **git**

## ⚙️ Installation

Clone the repository or download the script directly:

```bash
git clone https://github.com/your-username/setup-ts-project.git
cd setup-ts-project
chmod +x setup-ts-project.sh
```

## 💻 Usage

```bash
./setup-ts-project.sh [-h|--help] [-d|--directory <directory_path>] [-p|--package-manager <npm|yarn>] [-l|--libraries <libraries>] [-c|--create-structure] [-g|--git] [-w|--webapp]
```

### 🔍 Options

| Option                  | Description                                               |
|-------------------------|-----------------------------------------------------------|
| `-h`, `--help`          | Displays help message and available options               |
| `-d`, `--directory`     | Specifies the directory where the project will be created |
| `-p`, `--package-manager` | Choose the package manager (`npm` or `yarn`). Default is `npm` |
| `-l`, `--libraries`     | Space-separated list of additional libraries to install   |
| `-c`, `--create-structure` | Creates the basic project structure (`src/index.ts`)    |
| `-g`, `--git`           | Initializes a Git repository and creates a `.gitignore` file |
| `-w`, `--webapp`        | Creates a React TypeScript web application               |

## 🛠️ Examples

### Example 1: Initialize a basic TypeScript project with npm

```bash
./setup-ts-project.sh -d my_project -p npm -c -g
```

- Creates a project in the `my_project` directory
- Uses **npm** as the package manager
- Creates the basic structure (`src/index.ts`)
- Initializes a Git repository and adds a `.gitignore` file

### Example 2: Initialize a React TypeScript web application with yarn

```bash
./setup-ts-project.sh -d my_webapp -p yarn -w -l "react-router-dom styled-components" -g
```

- Creates a React TypeScript application in the `my_webapp` directory
- Uses **yarn** as the package manager
- Installs additional libraries: **react-router-dom** and **styled-components**
- Initializes a Git repository and adds a `.gitignore` file

### Example 3: Display help

```bash
./setup-ts-project.sh --help
```

- Displays the help message and available options

## 📂 Project Structure

After running the script with the `-c` option for a basic TypeScript project, your project will have the following structure:

```
my_project/
├── src/
│   └── index.ts
├── tsconfig.json
├── package.json
├── node_modules/
└── .gitignore
```

For a React TypeScript application (using the `-w` option), the structure is created by `create-react-app`.

## 📝 .gitignore

The script creates a default `.gitignore` file with the following entries:

```
node_modules
.env
dist
build
```

## ⚠️ Dependency Check

The script checks for the required tools before starting. If **npm**, **yarn**, **npx** (for React web apps), or **git** are not installed, the script will exit with an error message.

## 📖 Documentation

- [Node.js Documentation](https://nodejs.org/)
- [TypeScript Documentation](https://www.typescriptlang.org/docs/)
- [npm Documentation](https://docs.npmjs.com/)
- [yarn Documentation](https://yarnpkg.com/getting-started)
- [React Documentation](https://reactjs.org/docs/getting-started.html)

## 🛡️ License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## 🤝 Contributions

Contributions are welcome! Feel free to open an issue or a pull request.

## ✨ Authors

- JustOkaou - [GitHub Profile](https://github.com/justokaou)
- See the list of [contributors](https://github.com/your-username/setup-ts-project/contributors) who participated in this project.

---

🎉 Thank you for using `setup-ts-project.sh`! Happy coding! 🚀
