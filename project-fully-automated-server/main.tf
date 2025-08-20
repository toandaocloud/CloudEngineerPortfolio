# Khai báo provider
provider "aws" {
region = var.aws_region
}
# --- TẠO MÁY ẢO EC2 ---
resource "aws_instance" "web_server" {
ami = "ami-010876b9ddd38475e"
instance_type = "t3.micro"
user_data = file("install_nginx.sh")
key_name = "tidi1-key"
tags = {
Name = "tidi2"
}

}
# --- CẤU HÌNH DNS VỚI ROUTE 53 ---
# Lấy thông tin hosted zone của tên miền đã có
#data "aws_route53_zone" "my_domain" {
#name = var.domain_name
#}

# Tạo một bản ghi A trỏ tên miền về IP của EC2
#resource "aws_route53_record" "web_dns" {
 # zone_id = data.aws_route53_zone.my_domain.zone_id
  #name    = var.domain_name
  #type    = "A"
 # ttl     = 300
 # records = [aws_instance.web_server.public_ip]
#}
