resource "aws_ecs_cluster" "my_cluster" {
  name = "my-cluster-tf"
}
resource "aws_ecs_task_definition" "my_app_task" {
  family                   = "hello-world-app-task-tf"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  container_definitions = jsonencode([
    {
      name      = "hello-world-container",
      image     = var.ecr_image_uri,
      cpu       = 256,
      memory    = 512,
      essential = true,
      portMappings = [
        {
          containerPort = 80,
          hostPort      = 80
        }
      ]
    }
  ])
}
resource "aws_ecs_service" "my_app_service" {
  name            = "hello-world-service-tf"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_app_task.arn
  desired_count   = 2
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = data.aws_subnets.default.ids
    security_groups = [aws_security_group.alb_sg.id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.my_app_tg.arn
    container_name   = "hello-world-container"
    container_port   = 80
  }
  depends_on = [aws_lb_listener.http]
}
