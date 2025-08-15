# 1. Khai báo nhà cung cấp đám mây (AWS)
provider "aws" {
  region = "ap-southeast-2" # Em có thể chọn region khác nếu muốn
}

# 2. Định nghĩa một máy ảo EC2
resource "aws_instance" "my_first_server_tf" {
  ami           = "ami-010876b9ddd38475e" # Ubuntu 22.04 LTS for us-east-1
  instance_type = "t3.micro"             # Free Tier eligible

  tags = {    
    Name = "Server-Created-By-Terraform"
  }
}

