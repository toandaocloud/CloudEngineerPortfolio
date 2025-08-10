#!/bin/bash

# =================================================================
# A simple system health monitoring script for the portfolio
# Author: TOAN DAO
# Date: 2025-08-10
# =================================================================

# --- Cấu hình ---
# Nơi lưu file log. Dùng /tmp để an toàn, không cần quyền sudo.
LOG_FILE="/tmp/system_health.log"

# --- Các Hàm (Functions) ---
# Việc chia code thành các hàm giúp nó dễ đọc và dễ bảo trì.

# Hàm để lấy dấu thời gian hiện tại, định dạng YYYY-MM-DD HH:MM:SS
log_timestamp() {
  date "+%Y-%m-%d %H:%M:%S"
}

# Hàm kiểm tra dung lượng ổ đĩa
check_disk_usage() {
  echo "--- Disk Usage ---"
  # df -h / : Lấy thông tin ổ đĩa gốc, định dạng dễ đọc (GB, MB).
  # tail -n 1 : Chỉ lấy dòng cuối cùng của kết quả (dòng chứa thông tin).
  # awk '{print $5}' : Lấy cột thứ 5 (cột % sử dụng).
  df -h / | tail -n 1 | awk '{print "Usage: " $5 " (" $3 " / " $2 ") Total: " $4 " Free"}'
  echo "" # Thêm một dòng trống cho đẹp
}

# Hàm kiểm tra dung lượng RAM
check_memory_usage() {
  echo "--- Memory Usage ---"
  # free -m : Lấy thông tin RAM, đơn vị là Megabytes.
  # grep Mem : Chỉ lấy dòng có chứa thông tin về RAM vật lý.
  # awk '{...}' : In ra thông tin chi tiết.
  free -m | grep Mem | awk '{print "Usage: " $3 "MB / " $2 "MB Total (" int($3/$2*100) "%)"}'
  echo ""
}

# Hàm kiểm tra 5 tiến trình chiếm nhiều CPU nhất
check_cpu_usage() {
  echo "--- Top 5 CPU Consuming Processes ---"
  # ps aux --sort=-%cpu : Lấy tất cả tiến trình và sắp xếp theo %CPU giảm dần.
  # head -n 6 : Lấy 6 dòng đầu (1 dòng tiêu đề + 5 dòng tiến trình).
  ps aux --sort=-%cpu | head -n 6
  echo ""
}


# --- Logic Chính (Đây là nơi script bắt đầu chạy) ---

# Chuyển hướng tất cả các output (echo) sau dòng này vào file log.
# `>>` có nghĩa là "ghi tiếp vào cuối file", không ghi đè.
# `2>&1` có nghĩa là chuyển cả output lỗi (stderr) vào cùng chỗ với output thường (stdout).
exec >> "$LOG_FILE" 2>&1

# Bắt đầu ghi log
echo "================================================="
echo "Health Check Started at: $(log_timestamp)"
echo "================================================="
echo ""

# Gọi từng hàm để thực hiện kiểm tra
check_disk_usage
check_memory_usage
check_cpu_usage

echo "--- Health Check Finished ---"
echo ""
echo ""

