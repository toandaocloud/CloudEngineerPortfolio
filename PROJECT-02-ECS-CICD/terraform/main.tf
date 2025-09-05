terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# ========== INPUTS ==========
locals {
  project_name   = "ecs-cicd-tdcloud"
  container_port = 8000
}

# ========== VPC tối giản (2 public subnets) ==========
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = { Name = "${local.project_name}-vpc" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = { Name = "${local.project_name}-igw" }
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = { Name = "${local.project_name}-public-a" }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = { Name = "${local.project_name}-public-b" }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "${local.project_name}-public-rt" }
}

resource "aws_route_table_association" "assoc_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "assoc_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_rt.id
}

# ========== Security Group ==========
resource "aws_security_group" "svc_sg" {
  name        = "${local.project_name}-sg"
  description = "Allow HTTP"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${local.project_name}-sg" }
}

# ========== ECR Repository ==========
resource "aws_ecr_repository" "repo" {
  name                 = "${local.project_name}-repo"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
  tags = { Name = "${local.project_name}-repo" }
}

# ========== ECS Cluster ==========
resource "aws_ecs_cluster" "cluster" {
  name = "${local.project_name}-cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = { Name = "${local.project_name}-cluster" }
}

# ========== IAM cho ECS Task Execution ==========
data "aws_iam_policy_document" "assume_execution_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "task_execution_role" {
  name               = "${local.project_name}-exec-role"
  assume_role_policy = data.aws_iam_policy_document.assume_execution_role.json
}

resource "aws_iam_role_policy_attachment" "task_exec_attach" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ========== CloudWatch Log Group ==========
resource "aws_cloudwatch_log_group" "app" {
  name              = "/ecs/${local.project_name}"
  retention_in_days = 7
}

# ========== ECS Task Definition ==========
resource "aws_ecs_task_definition" "task" {
  family                   = "${local.project_name}-td"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "${aws_ecr_repository.repo.repository_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = local.container_port
          hostPort      = local.container_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.app.name
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  tags = { Name = "${local.project_name}-task" }
}

# ========== ECS Service (Fargate) ==========
resource "aws_ecs_service" "svc" {
  name            = "${local.project_name}-svc"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.public_a.id, aws_subnet.public_b.id]
    security_groups  = [aws_security_group.svc_sg.id]
    assign_public_ip = true
  }

  depends_on = [aws_iam_role_policy_attachment.task_exec_attach]
  tags = { Name = "${local.project_name}-service" }
}
