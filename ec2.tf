# -----------------------------
# web server
# -----------------------------
resource "aws_instance" "web_server" {
  ami           = var.ami_web_server
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [
    aws_security_group.web_server_sg.id,
  ]
  iam_instance_profile = aws_iam_instance_profile.iam_instance_profile_for_ec2.name
  private_ip           = var.private_ip_web_server

  user_data = file("${var.file_path_web_server}")

  tags = {
    Name    = "${var.project}-${var.environment}-web-server"
    Project = var.project
    Env     = var.environment
  }
}

# -----------------------------
# Windows Client
# -----------------------------
resource "aws_instance" "windows_client" {
  ami           = var.ami_windows_client
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [
    aws_security_group.windows_client_sg.id,
  ]
  iam_instance_profile = aws_iam_instance_profile.iam_instance_profile_for_ec2.name
  private_ip           = var.private_ip_windows_client

  user_data = file("${var.file_path_windows_client}")

  tags = {
    Name    = "${var.project}-${var.environment}-windows-client"
    Project = var.project
    Env     = var.environment
  }
}

# -----------------------------
# DNS Server
# -----------------------------
resource "aws_instance" "dns_server" {
  ami           = var.ami_dns_server
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [
    aws_security_group.dns_server_sg.id,
  ]
  iam_instance_profile = aws_iam_instance_profile.iam_instance_profile_for_ec2.name
  private_ip           = var.private_ip_dns_server

  user_data = file("${var.file_path_dns_server}")

  tags = {
    Name    = "${var.project}-${var.environment}-dns-server"
    Project = var.project
    Env     = var.environment
  }
}

# -----------------------------
# Proxy Server
# -----------------------------
resource "aws_instance" "proxy_server" {
  ami           = var.ami_proxy_server
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [
    aws_security_group.proxy_server_sg.id,
  ]
  iam_instance_profile = aws_iam_instance_profile.iam_instance_profile_for_ec2.name
  private_ip           = var.private_ip_proxy_server

  user_data = file("${var.file_path_proxy_server}")

  tags = {
    Name    = "${var.project}-${var.environment}-proxy-server"
    Project = var.project
    Env     = var.environment
  }
}

# -----------------------------
# Cloud9
# -----------------------------
resource "aws_cloud9_environment_ec2" "cloud9_environment" {
  name                        = "${var.project}-${var.environment}-cloud9-ec2"
  description = "for Bastion Server"
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet.id
  owner_arn                   = "arn:aws:iam::${var.project_account_id}:user/${var.project}"
  automatic_stop_time_minutes = 30

  # s3からダウンロードするために、IAM Roleをアタッチが必要（手動）

  tags = {
    EnvironmentName = "${var.project}-${var.environment}-cloud9-ec2"
    Project         = var.project
    Env             = var.environment
  }
}
