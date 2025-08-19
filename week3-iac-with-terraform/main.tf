# 1. Khai báo nhà cung cấp đám mây (AWS)
provider "aws" {
  region = var.aws_region # <-- THAY ĐỔI Ở ĐÂY
}

# 2. Định nghĩa một máy ảo EC2
resource "aws_instance" "my_first_server_tf" {
  ami           = var.ami_id        
  instance_type = var.instance_type

  tags = {
    Name = "Server-Created-By-Terraform-Vars"
  }
}
