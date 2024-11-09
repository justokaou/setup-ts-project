# 🛠️ setup-ts-node.sh

`setup-ts-node.sh` is a Bash script to quickly set up a **Node.js** project with **TypeScript**. It automates project initialization, TypeScript configuration, additional library installation, and Git initialization.

## 📋 Prerequisites

Ensure that you have the following tools installed on your system:
- **Node.js** (version 14+)
- **npm** or **yarn**
- **git**

## ⚙️ Installation

Clone the repository or download the script directly:

```bash
git clone https://github.com/your-username/setup-ts-node.git
cd setup-ts-node
chmod +x setup-ts-node.sh
```

## 💻 Usage

```bash
./setup-ts-node.sh [-h|--help] [-d|--directory <directory_path>] [-p|--package-manager <npm|yarn>] [-l|--libraries <libraries>] [-c|--create-structure] [-g|--git]
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

## 🛠️ Examples

### Example 1: Initialize a project with npm

```bash
./setup-ts-node.sh -d my_project -p npm -c -g
```

- Creates a project in the `my_project` directory
- Uses **npm** as the package manager
- Creates the basic structure (`src/index.ts`)
- Initializes a Git repository and adds a `.gitignore` file

### Example 2: Initialize a project with yarn and install additional libraries

```bash
./setup-ts-node.sh -d my_project -p yarn -l "express lodash" -c -g
```

- Creates a project in the `my_project` directory
- Uses **yarn** as the package manager
- Installs the libraries **express** and **lodash**
- Creates the basic structure (`src/index.ts`)
- Initializes a Git repository and adds a `.gitignore` file

### Example 3: Display help

```bash
./setup-ts-node.sh --help
```

- Displays the help message and available options

## 📂 Project Structure

After running the script with the `-c` option, your project will have the following structure:

```
my_project/
├── src/
│   └── index.ts
├── tsconfig.json
├── package.json
├── node_modules/
└── .gitignore
```

## 📝 .gitignore

The script creates a default `.gitignore` file with the following entries:

```
node_modules
.env
dist
build
```

## ⚠️ Dependency Check

The script checks for the required tools before starting. If **npm**, **yarn**, or **git** are not installed, the script will exit with an error message.

## 📖 Documentation

- [Node.js Documentation](https://nodejs.org/)
- [TypeScript Documentation](https://www.typescriptlang.org/docs/)
- [npm Documentation](https://docs.npmjs.com/)
- [yarn Documentation](https://yarnpkg.com/getting-started)

## 🛡️ License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## 🤝 Contributions

Contributions are welcome! Feel free to open an issue or a pull request.

## ✨ Authors

- [@dyfault-eth](https://www.github.com/dyfault-eth)
- See the list of [contributors](https://github.com/dyfault-eth/setup-ts-node/contributors) who participated in this project.

---

🎉 Thank you for using `setup-ts-node.sh`! Happy coding! 🚀
