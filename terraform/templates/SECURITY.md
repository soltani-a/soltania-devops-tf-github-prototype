# Security Policy

This project serves as a technical **Showcase** demonstrating automated API testing and DevOps practices. While this is a demonstration repository, we adhere to professional security standards and best practices.

## 📦 Supported Versions

Only the latest version available on the main branch is actively maintained and supported.

| Version | Supported          |
| ------- | ------------------ |
| `main`  | :white_check_mark: |
| Old tags| :x:                |

## 🐞 Reporting a Vulnerability

If you discover a security vulnerability within this project (e.g., exposed secrets in workflows, compromised dependencies, or script injection flaws), **please do not open a public Issue**.

We practice **Responsible Disclosure**. Please follow these steps:

1.  Reach out to Slim SOLTANI via [LinkedIn](https://www.linkedin.com/in/slimsoltani/).
2.  Provide a brief description of the vulnerability and steps to reproduce it.
3.  We will acknowledge receipt within **48 hours**.
4.  A patch will be deployed publicly once the vulnerability has been analyzed and resolved.

## ⚠️ Scope

### In Scope
* **Bruno Test Scripts** (`.bru` files) and associated JavaScript logic.
* **CI/CD Configuration**: GitHub Actions workflows located in `.github/workflows/`.
* **Project Configuration**: `package.json`, `bruno.json`, and dependency definitions.

### Out of Scope
* **Bruno CLI**: Vulnerabilities related to the testing tool itself should be reported to the [UseBruno](https://github.com/usebruno/bruno) team.
* **JsonPlaceholder API**: We are not responsible for the public mock API used as a target for these tests.
* **Third-party npm packages**: Vulnerabilities in upstream dependencies should be managed via `npm audit` or Dependabot alerts.

---

*This policy is established to demonstrate compliance with GitHub Community Standards.*