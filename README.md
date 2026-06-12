# ABS Mentoring Infrastructure

This project uses **Terraform** to manage secure Azure infrastructure for the ABS Mentoring platform. It provisions a Storage Account and Key Vault with strictly enforced network firewalls.

## 🛠 Prerequisites

1.  **Terraform CLI**: [Install here](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).
2.  **Azure CLI**: Authenticate your session before running commands:
    ```bash
    az login
    ```

## 🏗 Infrastructure Overview

* **Storage Account**: `absmentoring` (Standard GRS) with a private `input` container.
* **Key Vault**: `absmentoring` (Standard SKU) for secret management.
* **Security**: Both resources use a **Default Deny** network policy, only allowing traffic from whitelisted VPN/Office IPs and specific GitLab Runner subnets.
* **Remote State**: State is stored in the `mentoringtfstate` Azure Storage container.

---

## 🚀 How to Run locally

### 1. Initialize
Set up the remote backend and download the necessary Azure providers.
```bash
terraform init
```

### 2. Plan
Preview the changes Terraform will perform in your Azure environment.
```bash
terraform plan
```

### 3. Apply
Provision the infrastructure. You must type yes to confirm the deployment.
```bash
terraform apply
```

CI/CD pipeline will automatically deploy the changes pushed to git.