# Project 3: Fully Automated ECS Cluster Deployment with Terraform

## Overview
This project automates the entire provisioning of a high-availability, load-balanced application environment on **AWS Elastic Container Service (ECS)** using Terraform. It defines all components as code, including networking, security, load balancing, and the container service itself, enabling one-command deployment.

## Architecture Components
- **Networking:** Utilizes the default VPC and subnets for simplicity, retrieved using `data` sources.
- **Security:** Provisions a dedicated `aws_security_group` for the Application Load Balancer (ALB), allowing public HTTP traffic.
- **Load Balancing:** Deploys an `aws_lb` (ALB), an `aws_lb_target_group`, and an `aws_lb_listener` to distribute traffic.
- **ECS:**
    - `aws_ecs_cluster`: Creates the logical grouping for the services.
    - `aws_ecs_task_definition`: Defines the application container (using an image from ECR), its CPU/memory requirements, and port mappings.
    - `aws_ecs_service`: Manages the application, ensuring a desired number of tasks are always running and registering them with the ALB's target group.

## Business Value
This project demonstrates a complete Infrastructure as Code workflow for cloud-native applications. Automating the ECS stack provides:
- **Rapid Provisioning:** Deploying a complex, multi-resource environment takes minutes instead of days of manual work.
- **Configuration Consistency:** Eliminates "configuration drift" and ensures all environments (dev, staging, prod) are identical.
- **Scalability & Reliability:** Creates a foundation that is inherently scalable and self-healing, managed by the ECS Service.
