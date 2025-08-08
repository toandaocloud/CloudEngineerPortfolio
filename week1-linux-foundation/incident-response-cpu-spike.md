# Incident Report: High CPU Usage on web-server-01

## 1. Issue Description
A high CPU usage alert was triggered for `web-server-01`. Initial analysis showed one core was at 100% utilization, causing service slowdown.

## 2. Investigation Steps
* **Real-time Monitoring:** Used `htop` to get a live view of system processes.
* **Root Cause Identification:** Immediately identified a `bash` process with **PID 23451** (replace with your actual PID) as the root cause, consuming 99.8% CPU.
* **Static Verification:** Cross-verified the process information using `ps aux | grep 23451` to get a static snapshot.

## 3. Resolution
* **Graceful Termination Attempt:** A `SIGTERM` signal was sent using `kill 23451`. The process was unresponsive, indicating it was stuck.
* **Forced Termination:** Escalated to a `SIGKILL` signal using `kill -9 23451`.
* **Verification:** Confirmed in `htop` that the process was successfully terminated and system CPU load returned to normal levels (< 5%).

## Business Value
This incident demonstrates the ability to rapidly diagnose and resolve system performance bottlenecks. This "firefighting" skill is crucial for maintaining service availability (SLA), minimizing financial impact from downtime, and ensuring a positive user experience.
