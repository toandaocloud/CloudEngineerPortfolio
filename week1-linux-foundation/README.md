# Week 1: Linux Foundation - Project Setup Automation

## Description
This simple Bash script (`setup_project.sh`) automates the creation of a standard directory structure (`td`, `la`, `at`) for new software projects.

## Skills Demonstrated
- **Basic Linux CLI:** `mkdir`, `echo`, `ls`, `chmod`.
- **Bash Scripting:** Creating and executing a `.sh` file with the correct shebang (`#!/bin/bash`).
- **Automation Mindset:** Identifying a repetitive task and automating it to save time and ensure consistency.

## Business Value
This script, while simple, represents a foundational step in DevOps. In an enterprise environment, this principle is scaled up to automate server provisioning and application deployments, leading to:
- **Increased Efficiency:** Reduces manual, error-prone setup time.
- **Standardization:** Ensures every project starts with a consistent, approved structure.

---

## Day 2: File Permissions & Security

Practiced fundamental Linux security by managing file permissions (`chmod`) and ownership (`chown`). This is a critical skill to protect system integrity and sensitive data.

### Key Commands & Concepts
- **`chmod 640 [file]`**: Applied to `config.yml`. This permission (`rw-r-----`) is crucial for sensitive files, allowing the owner to read/write, the group to only read, and denying all access to others.
- **`chmod 755 [file]`**: Applied to `deploy.sh`. This permission (`rwxr-x--x`) is standard for executable scripts, allowing everyone to run it but restricting modification to the owner only.
- **`sudo chown [user]:[group] [file]`**: Changed the group ownership to `developers`, enabling controlled team collaboration.
- **User Management**: Used `useradd` and `groupadd` to create a test environment, validating that the permission rules work as expected in a multi-user scenario.

### Business Value
Properly configured permissions are the first line of defense against both unauthorized access and accidental system modifications. Mastering this skill is non-negotiable for protecting company assets (like API keys in config files), ensuring system stability, and complying with security standards like ISO 27001 or SOC 2.
