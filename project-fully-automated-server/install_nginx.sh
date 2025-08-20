#!/bin/bash
apt-get update
apt-get install -y nginx
systemctl start nginx
systemctl enable nginx
echo  "<h1>chao mung cac ban den voi web cua toandao</h1>" > /var/www/html/index.html
