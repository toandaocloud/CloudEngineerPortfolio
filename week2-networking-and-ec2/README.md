# Week 2: Networking Fundamentals & First EC2 Instance

This week marks the beginning of the journey into the cloud. I have provisioned my first piece of cloud infrastructure: an Amazon Web Services (AWS) EC2 instance.

## 1. Networking Concepts Learned
- **IP Address:** The unique address of a server on the internet.
- **TCP/IP:** The protocol suite that governs how data is transmitted and received.
- **DNS:** The "phonebook" of the internet that translates human-readable domain names into machine-readable IP addresses.

## 2. Lab: Launching an EC2 Instance
I successfully launched a `t2.micro` EC2 instance running Ubuntu Server. Key steps included:
- Selecting an Amazon Machine Image (AMI).
- Choosing an instance type eligible for the AWS Free Tier.
- Creating a new **Key Pair** (`.pem` file) for secure SSH access.
- Configuring a **Security Group** to act as a virtual firewall, initially allowing only SSH traffic on port 22.

## Business Value
Provisioning a virtual server is the most fundamental task in cloud computing. This demonstrates the ability to create the basic building block for any cloud-based application. Understanding how to configure security groups and manage key pairs is a critical security skill to protect company assets from unauthorized access.

## 4. Lab: Deploying a Custom HTML Page on Nginx
Successfully replaced the default Nginx welcome page with a custom "Hello World" HTML page.
- **Process:**
    - Identified the Nginx document root at `/var/www/html`.
    - Encountered and understood a `Permission denied` error, reinforcing knowledge of Linux file ownership from Week 1.
    - Used `sudo` to gain the necessary privileges to create and edit files in the root-owned web directory.
    - Created a new `index.html` file, which Nginx automatically serves by default, effectively deploying a custom webpage.
- **Outcome:** Hosted a personalized static website, accessible globally via the EC2 instance's public IP address.
