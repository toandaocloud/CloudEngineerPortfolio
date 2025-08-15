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

## 5. Lab: Integrating S3 for Static Asset Storage
To optimize the web application, I leveraged **AWS S3** for storing and serving static assets (images).
- **Process:**
    - Created a new, globally unique S3 bucket.
    - Configured the bucket's **Public Access Block** settings to allow public read access, a necessary step for web hosting.
    - Uploaded an image object to the bucket.
    - Explicitly set the object's permissions (Access Control List - ACL) to be publicly readable.
    - Modified the `index.html` file on the EC2 instance to reference the image using its S3 **Object URL**.
- **Outcome:** Successfully decoupled static content from the application server. The EC2 instance now only serves the HTML, while the image is served directly from S3, improving performance and scalability.

## 6. Lab: DNS Configuration with Route 53
To provide a professional and user-friendly access point to the web application, I registered a custom domain name and configured DNS using **AWS Route 53**.
- **Process:**
    - Registered a new domain directly through the AWS Route 53 service.
    - A **Hosted Zone** for the domain was automatically created.
    - Created an **`A` Record** within the hosted zone.
    - This `A` record maps the domain name directly to the **Public IPv4 address** of the EC2 instance.
- **Outcome:** The web application is now accessible via a custom domain name (e.g., `http://my-awesome-domain.com`) instead of a hard-to-remember IP address. This is a fundamental step for any production-grade web service.

## 7. Lab: Securing the Web Server with HTTPS
To ensure secure communication and build user trust, I implemented HTTPS on the web server.
- **Process:**
    - Leveraged **Let's Encrypt**, a free and automated Certificate Authority, to obtain an SSL/TLS certificate.
    - Installed **Certbot** and its Nginx plugin (`python3-certbot-nginx`) on the EC2 instance.
    - Ran the `certbot` command, which automatically verified domain ownership, fetched the certificate, and modified the Nginx configuration.
    - Opted to automatically redirect all insecure `HTTP` traffic to secure `HTTPS`.
- **Outcome:** The website is now served over HTTPS, with a valid SSL certificate, indicated by the lock icon 🔒 in the browser. All traffic between the user and the server is now encrypted. This is a standard requirement for all modern web applications.
