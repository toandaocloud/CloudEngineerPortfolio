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
