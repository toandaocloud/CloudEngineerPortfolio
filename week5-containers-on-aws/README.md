# Week 5: Deploying and Managing Containers on AWS

This week marks the transition from local container management to professional, cloud-native container workflows on AWS. The focus is on building a secure, automated, and scalable pipeline for our containerized applications.

---

## 1. Project: Secure Image Management with AWS ECR

This initial project established a secure and private artifact registry for our application's Docker images, a foundational step for any production-grade deployment strategy.

- **Problem:** Storing proprietary application images on public registries like Docker Hub is a significant security risk. It exposes intellectual property and lacks robust, integrated access control for an enterprise environment.

- **Solution:**
    1.  **Provision ECR:** I used the AWS CLI to provision a new private repository in Amazon Elastic Container Registry (ECR).
    2.  **Enable Security Scanning:** The repository was configured with `scanOnPush=true`, leveraging AWS's built-in capabilities to automatically scan images for known software vulnerabilities (CVEs).
    3.  **Secure Authentication:** I implemented the standard, secure authentication method by using `aws ecr get-login-password` to obtain a short-lived authorization token, which was then piped to the `docker login` command. This avoids the use of static, long-lived credentials.
    4.  **Image Push Workflow:** I tagged the locally built `visit-counter-app` image with the ECR repository URI and successfully pushed it to the private registry.

- **Outcome:** A centralized, secure, and highly-available private registry for all container images. This process completely decouples our development workflow from public registries and integrates it tightly with AWS IAM for granular access control.

## Business Value

Protecting intellectual property is paramount. By using a private registry like ECR, a company prevents its proprietary code, packaged within images, from being publicly exposed. The automated vulnerability scanning provides a critical layer of security, allowing teams to identify and patch risks before they reach production. This practice is fundamental to achieving compliance (like SOC 2, ISO 27001) and building trust with customers.
---

## 2. Project: Automated Deployment to EC2 with User Data

This project demonstrated a hands-off, automated deployment of a containerized application onto a fresh EC2 instance at boot time.

- **Problem:** Manually provisioning servers by SSHing in to install dependencies and run applications is slow, not repeatable, and highly prone to human error, making it unsuitable for modern infrastructure.

- **Solution:**
    1.  **IAM Role for EC2:** I created a dedicated IAM Instance Profile (`EC2-ECR-Pull-Role`) with the `AmazonEC2ContainerRegistryReadOnly` policy attached. This securely granted the EC2 instance permissions to pull images from ECR without hardcoding any credentials.
    2.  **User Data Script:** I authored a bootstrap script that runs automatically on the instance's first boot. This script handles the entire setup process: updating packages, installing Docker, authenticating with ECR using its IAM role, pulling the latest application image, and running the container with the correct port mapping.
    3.  **Automated Launch:** The EC2 instance was launched with the IAM role and User Data script configured, resulting in a fully functional and deployed application without any manual intervention post-launch.

- **Outcome:** A "zero-touch" deployment model. New compute capacity can now be brought online with the application running and ready to serve traffic within minutes. This process is repeatable, reliable, and forms the basis for more advanced concepts like auto-scaling.

## Business Value

Automating infrastructure provisioning dramatically reduces the risk of deployment errors and shortens the time-to-market for new features. This "Infrastructure as Code" approach ensures consistency across environments (development, staging, production). For the business, this means higher reliability, increased developer velocity, and the ability to elastically scale the application in response to user demand, optimizing costs and performance.
---

## 3. Project: Introduction to Container Orchestration with ECS

This project was my first step into the world of managed container orchestration, addressing the critical flaws of a single-container-on-a-single-server architecture.

- **Problem:** The previous deployment model (Day 23) was a single point of failure and had no built-in mechanism for scaling or self-healing, making it unsuitable for any production workload.

- **Solution:** I utilized Amazon Elastic Container Service (ECS) with the AWS Fargate launch type to deploy the application in a managed, resilient, and serverless environment.
    1.  **ECS Cluster:** Created a logical cluster to group and manage my application's resources.
    2.  **Task Definition:** Authored a detailed "blueprint" for my application, specifying the container image, CPU/memory requirements, and port mappings.
    3.  **ECS Service:** Deployed the application using an ECS Service, instructing it to maintain a "desired count" of running tasks at all times. This introduces the key capabilities of self-healing and easy scaling.

- **Outcome:** The application is now managed by a powerful orchestrator. If the container fails, the ECS Service will automatically replace it. To scale out, I only need to increase the "desired count" instead of manually provisioning new servers. This lays the foundation for a truly robust and scalable architecture.

## Business Value

Container orchestrators like ECS are the backbone of modern cloud-native applications. By using a managed service, companies drastically reduce operational overhead, eliminate single points of failure, and gain the agility to scale services in response to real-time demand. This directly translates to higher application uptime (better customer experience), improved developer productivity, and more efficient use of cloud resources (cost savings).
