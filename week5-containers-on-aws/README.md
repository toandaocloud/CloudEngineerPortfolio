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
