# Project 1: System Health Monitoring Bash Script

## Overview
This project is a Bash script (`health_monitor.sh`) designed to run on a Linux server and provide automated health checks. It monitors critical system resources like disk usage, memory, and high-CPU processes, appending the results to a log file for historical analysis. This is a foundational tool for any system administrator or Cloud Engineer to ensure server stability.

## Features
- **Disk Usage Monitoring:** Checks the usage of the root filesystem and reports it in a human-readable format (Usage %, Used, Total).
- **Memory Usage Monitoring:** Reports used and total memory, including the usage percentage.
- **CPU Load Analysis:** Lists the top 5 processes currently consuming the most CPU, helping to identify performance bottlenecks.
- **Automated Logging:** Appends a timestamped report to `/tmp/system_health.log`, allowing for trend analysis and post-mortem troubleshooting.

## Skills Demonstrated
- **Advanced Shell Scripting (Bash):** Utilization of variables, functions for modularity, and command substitution `$(...)`.
- **Linux System Commands:** `df`, `free`, `ps`, `date`, `head`.
- **Text Processing for Data Extraction:** `grep` and `awk` to parse command output and extract key metrics.
- **File I/O and Redirection:** Redirecting stdout and stderr to a log file (`exec >> ... 2>&1`) for robust, silent execution suitable for cron jobs.
- **Core System Administration:** Implementing fundamental server monitoring and proactive health check principles.

## Business Value
Automating system health checks provides early warnings for potential issues like running out of disk space or memory leaks. This proactive monitoring helps prevent service outages, ensures system reliability (improving SLA), and frees up valuable engineering time from manual, repetitive checks. This directly contributes to higher service uptime and improved operational efficiency.
