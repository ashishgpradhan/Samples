# Infrastructure as Code (IaC) Directory

## Overview

This directory contains Infrastructure as Code (IaC) files, primarily for managing and provisioning cloud infrastructure using [Terraform](https://www.terraform.io/). The files define resources, variables, and configurations needed to automate infrastructure deployment in a consistent and repeatable manner.

---

## Directory Structure

- **.tf files**  
  Main Terraform configuration files. These files declare resources, providers, modules, and outputs.

- **.tfvars / .tfvars.json**  
  Variable definition files. These are used to set values for variables defined in the Terraform configuration.

- **.terraform/**  
  Local directory created by Terraform to store state and cache provider plugins.  
  _Ignored by version control as per `.gitignore`._

- **.tfstate / .tfstate.\***  
  Terraform state files. These files track the current state of your infrastructure.  
  _Ignored by version control as per `.gitignore`._

- **override.tf / *_override.tf**  
  Local override files for resource definitions.  
  _Ignored by version control as per `.gitignore`._

- **crash.log**  
  Log file generated if Terraform crashes.  
  _Ignored by version control as per `.gitignore`._

- **.terraformrc / terraform.rc**  
  CLI configuration files for Terraform.  
  _Ignored by version control as per `.gitignore`._

---

## Best Practices

- **Do not commit sensitive files** such as `.tfstate`, `.tfvars`, or any file containing secrets or credentials.
- **Use variables** for environment-specific values and keep them in separate `.tfvars` files.
- **Store state files securely** (consider using remote backends like S3 with state locking).
- **Review the `.gitignore`** to ensure sensitive or local-only files are not tracked by git.

---

## Getting Started

1. **Initialize Terraform:**
   ```bash
   terraform init
   ```

2. **Plan Infrastructure Changes:**
   ```bash
   terraform plan -var-file="your-variables.tfvars"
   ```

3. **Apply Infrastructure Changes:**
   ```bash
   terraform apply -var-file="your-variables.tfvars"
   ```

---

## Notes

- Make sure to review and customize variable values and resource definitions according to your environment and requirements.
- For more information, refer to the [Terraform documentation](https://www.terraform.io/docs/).

---