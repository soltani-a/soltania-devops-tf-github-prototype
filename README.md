# 🚀 Soltania DevOps: GitHub Infrastructure as Code

[![Terraform](https://img.shields.io/badge/Terraform-%3E%3D1.5-purple?logo=terraform)](https://www.terraform.io/)
[![Bash](https://img.shields.io/badge/Shell-Bash-black?logo=gnu-bash)](https://www.gnu.org/software/bash/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Status](https://img.shields.io/badge/Status-PoC-orange)]()

**Standardizing GitHub Repository Management via Terraform & Automation Wrappers.**

This project serves as a **Proof of Concept (PoC)** and a **Template** for managing GitHub organizations via Infrastructure as Code (IaC). It abstracts the complexity of Terraform CLI commands through robust Bash wrappers, ensuring a consistent, secure, and streamlined workflow for DevOps engineers.

---

## 🏛️ Architecture & Workflow

This project implements a **GitOps-adjacent workflow**. Changes are defined in code, validated via local scripts, and applied to the GitHub API.

```mermaid
flowchart TD
    subgraph "Local Developer Environment"
        Dev[👱 Architect / DevOps]
        
        subgraph "Automation Layer (Scripts)"
            Wrapper[⚙️ tf_wrapper.sh]
            Publisher[🚀 publish.sh]
        end
        
        TF[🏗️ Terraform Core]
    end

    subgraph "Remote Infrastructure"
        GitHubAPI[☁️ GitHub API]
        Repo[📦 Target Repositories]
        GitRemote[🗄️ This Git Repo]
    end

    Dev -->|1. Define Infra| Wrapper
    Wrapper -->|fmt / plan / apply| TF
    TF -->|Provision| GitHubAPI
    GitHubAPI -->|Create/Update| Repo
    
    Dev -->|2. Save Code| Publisher
    Publisher -->|fmt / commit / push| GitRemote