# Contributing to Soltania DevOps Project

First off, thank you for considering contributing to this project. As a Solutions Architect initiative, we value code quality, standardization, and clear documentation.

## 🛠 Workflow
1.  **Fork** the repository.
2.  **Create** a feature branch (`git checkout -b feature/amazing-feature`).
3.  **Run** `./scripts/tf_wrapper.sh fmt` to ensure HCL compliance.
4.  **Commit** your changes using conventional commits (e.g., `feat: add new repository variable`).
5.  **Push** to the branch and open a **Pull Request**.

## 🧪 Requirements
* All Terraform code must be formatted (`terraform fmt`).
* Scripts must pass ShellCheck (if applicable).
* Documentation must be updated if variables change.