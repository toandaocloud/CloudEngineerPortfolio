# Week 3: Infrastructure as Code with Terraform

This week, I transitioned from manual infrastructure management ("ClickOps") to an automated, code-driven approach using **Infrastructure as Code (IaC)**. I began learning **Terraform**, the industry-standard tool for provisioning cloud resources.

## 1. Lab: Provisioning an EC2 Instance with Terraform
I successfully wrote my first Terraform configuration file (`main.tf`) to programmatically provision an AWS EC2 instance.
- **Process:**
    - Installed and configured Terraform on my local development environment.
    - Wrote a configuration file defining an `aws` provider and an `aws_instance` resource.
    - Specified the Amazon Machine Image (AMI) and instance type (`t2.micro`) in the code.
    - Used the core Terraform workflow: `terraform init`, `terraform plan`, and `terraform apply` to deploy the infrastructure.
- **Outcome:** An EC2 instance was automatically created and configured based on the code, perfectly matching the desired state.

## Business Value
IaC is a cornerstone of modern DevOps and Cloud Engineering. By defining infrastructure in code:
- **Automation & Speed:** We can deploy complex environments in minutes, not hours.
- **Consistency & Reliability:** Eliminates human error from manual configuration, ensuring every environment is identical.
- **Version Control:** Infrastructure changes can be tracked, reviewed, and rolled back just like application code, dramatically improving stability.

## 2. Lab: Refactoring with Terraform Variables
I refactored the initial Terraform configuration to use variables, making the code reusable and more maintainable.
- **Process:**
    - Created a `variables.tf` file to declare variables for `aws_region`, `instance_type`, and `ami_id`.
    - Created a `terraform.tfvars` file to assign specific values to these variables. This separates the configuration data from the logic.
    - Updated `main.tf` to reference the variables using the `var.` syntax (e.g., `var.aws_region`).
    - Created a `.gitignore` file to explicitly exclude `terraform.tfvars` from version control, which is a critical security best practice.
- **Outcome:** The infrastructure code is now parameterized. To deploy the same infrastructure in a different region or with a different instance size, I only need to change the values in the `.tfvars` file, without touching the core logic in `main.tf`.
