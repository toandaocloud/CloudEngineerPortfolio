# Project 2: Fully Automated Web Server Deployment with Terraform

## Overview
This project demonstrates a complete, automated deployment of a production-ready static web server on AWS using **Infrastructure as Code (IaC)** with Terraform. A single `terraform apply` command provisions and configures all necessary resources, transforming a manual, multi-day setup into an automated, minutes-long process.

## Architecture
The infrastructure consists of the following core components managed by Terraform:

* **AWS EC2:** A `t2.micro` instance serves as the web server, running Ubuntu 22.04. The latest AMI is fetched dynamically using a `data source`.
* **Nginx:** Automatically installed and configured on the EC2 instance at boot time via a `user_data` script.
* **AWS Security Group:** A security group is provisioned from scratch to act as a stateful firewall, allowing inbound traffic only on necessary ports (SSH, HTTP, HTTPS).
* **(Optional) AWS Route 53:** An `A` record is created to point a custom domain name to the EC2 instance's public IP address.

*Thầy khuyến khích em dùng một công cụ online như `draw.io` (diagrams.net) để vẽ một sơ đồ kiến trúc đơn giản, lưu ảnh lại và chèn vào đây. Nó sẽ làm portfolio của em nổi bật hơn 100 lần!*

## Key Skills Demonstrated
- **Advanced Terraform:**
    - **Data Sources:** Used `data "aws_ami"` to programmatically find the latest Ubuntu AMI, eliminating hardcoded values.
    - **Resource Provisioning:** Managed the lifecycle of `aws_instance` and `aws_security_group`.
    - **File Provisioning:** Used the `file()` function to pass a shell script to the instance's `user_data`.
    - **Modular Code:** Organized code into logical files (`main.tf`, `variables.tf`, `outputs.tf`, `securitygroup.tf`).
- **Automated Server Configuration:** Utilized `user_data` for hands-free server bootstrapping, a core DevOps practice.
- **Networking & Security:** Defined and managed firewall rules (Security Groups) entirely through code.

## Business Value
This automated approach provides immense business value:
- **Drastic Time Reduction:** Reduces deployment time from hours/days to minutes.
- **100% Reproducibility:** Guarantees that development, staging, and production environments are identical, eliminating "it works on my machine" errors.
- **Disaster Recovery:** The entire infrastructure can be rebuilt from scratch in a new region with a single command in case of a disaster.
