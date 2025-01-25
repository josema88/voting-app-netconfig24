# Terraform Azure Project

This project uses Terraform to deploy resources in Azure. All Terraform configuration code is contained in a single file, `main.tf`.

## Prerequisites

Before running this project, ensure you have the following tools installed:

- [Terraform](https://www.terraform.io/downloads) (version 1.x or higher)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) for authentication
- Azure credentials configured for Terraform to authenticate and create resources

## Steps to Run

1. **Clone this repository** or copy the files to your local machine:

    ```bash
    git clone <repository-url>
    cd <repository-directory>
    ```

2. **Move to the directory** where main.tf is located:

    ```bash
    cd k8s-infra/azure/terraform
    ```

3. **Initialize Terraform** to install the Azure provider plugin:

    ```bash
    terraform init
    ```

4. **Review the execution plan** (optional but recommended to verify what will be created/modified/destroyed):

    ```bash
    terraform plan
    ```

5. **Apply the plan** to execute the configuration and create the resources in Azure:

    ```bash
    terraform apply
    ```

    Terraform will prompt you for confirmation before proceeding. Type `yes` and press Enter.

6. **Verify the resource state**:

    To view the state of the resources created or managed by Terraform, use:

    ```bash
    terraform show
    ```

## Destroy Resources

If you want to delete the resources created by Terraform, run:

```bash
terraform destroy
```
