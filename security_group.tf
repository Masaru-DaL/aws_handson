# -----------------------------
# Security Group for Web Server
# -----------------------------
resource "aws_security_group" "web_server_sg" {
  name        = "${var.project}-${var.environment}-web-server-sg"
  description = "Allow traffic for web server"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name    = "${var.project}-${var.environment}-web-server-sg"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_security_group_rule" "web_server_in_ssh" {
  security_group_id = aws_security_group.web_server_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  description = "from Cloud9"

  // 起動後にCloud9のIPアドレスを指定する必要がある。
  cidr_blocks = [
    # Cloud9 Public IP Address
    "${var.subnet_public_cidr_block}",
  ]
}

resource "aws_security_group_rule" "web_server_in_http" {
  security_group_id = aws_security_group.web_server_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  description = "from Proxy Server"

  cidr_blocks = [
    # Proxy Server Private IP Address
    "${var.private_ip_proxy_server}/32",
  ]
}

resource "aws_security_group_rule" "web_server_in_https" {
  security_group_id = aws_security_group.web_server_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  description = "from Proxy Server"

  cidr_blocks = [
    # Proxy Server Private IP Address
    "${var.private_ip_proxy_server}/32",
  ]
}

resource "aws_security_group_rule" "web_server_out_all" {
  security_group_id = aws_security_group.web_server_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# -----------------------------
# Security Group for Cloud9
# -----------------------------
resource "aws_security_group" "cloud9_sg" {
  name        = "${var.project}-${var.environment}-cloud9-sg"
  description = "Allow traffic for cloud9"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name    = "${var.project}-${var.environment}-cloud9-sg"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_security_group_rule" "cloud9_in_ssh" {
  security_group_id = aws_security_group.cloud9_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22

  cidr_blocks = [
    # Client Public IP Address
    "${var.public_ip_client}/32",
  ]
}

resource "aws_security_group_rule" "cloud9_out_all" {
  security_group_id = aws_security_group.cloud9_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# -----------------------------
# Security Group for Windows Client
# -----------------------------
resource "aws_security_group" "windows_client_sg" {
  name        = "${var.project}-${var.environment}-windows-client-sg"
  description = "Allow traffic for windows client"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name    = "${var.project}-${var.environment}-windows-client-sg"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_security_group_rule" "windows_client_in_rdp" {
  security_group_id = aws_security_group.windows_client_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 3389
  to_port           = 3389
  description = "from My Client"

  cidr_blocks = [
    # Client Public IP Address
    "${var.public_ip_client}/32",
  ]
}

resource "aws_security_group_rule" "windows_client_out_all" {
  security_group_id = aws_security_group.windows_client_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# -----------------------------
# Security Group for DNS Server
# -----------------------------
resource "aws_security_group" "dns_server_sg" {
  name        = "${var.project}-${var.environment}-dns-server-sg"
  description = "Allow traffic for dns server"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name    = "${var.project}-${var.environment}-dns-server-sg"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_security_group_rule" "dns_server_in_ssh" {
  security_group_id = aws_security_group.dns_server_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  description = "from Cloud9"

  cidr_blocks = [
    # Cloud9 Public IP Address
    "${var.subnet_public_cidr_block}",
  ]
}

resource "aws_security_group_rule" "dns_server_in_dns_tcp" {
  security_group_id = aws_security_group.dns_server_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 53
  to_port           = 53
  description = "from Proxy Server"

  cidr_blocks = [
    # Proxy Server Private IP Address
    "${var.private_ip_proxy_server}/32",
  ]
}

resource "aws_security_group_rule" "dns_server_in_dns_udp" {
  security_group_id = aws_security_group.dns_server_sg.id
  type              = "ingress"
  protocol          = "udp"
  from_port         = 53
  to_port           = 53
  description = "from Proxy Server"

  cidr_blocks = [
    # Proxy Server Private IP Address
    "${var.private_ip_proxy_server}/32",
  ]
}

resource "aws_security_group_rule" "dns_server_out_all" {
  security_group_id = aws_security_group.dns_server_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# -----------------------------
# Security Group for Proxy Server
# -----------------------------
resource "aws_security_group" "proxy_server_sg" {
  name        = "${var.project}-${var.environment}-proxy-server-sg"
  description = "Allow traffic for proxy server"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name    = "${var.project}-${var.environment}-proxy-server-sg"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_security_group_rule" "proxy_server_in_ssh" {
  security_group_id = aws_security_group.proxy_server_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  description = "from Cloud9"

  cidr_blocks = [
    # Cloud9 Public IP Address
    "${var.subnet_public_cidr_block}",
  ]
}


resource "aws_security_group_rule" "proxy_server_in_http" {
  security_group_id = aws_security_group.proxy_server_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 8080
  to_port           = 8080
  description = "from Windows Client"

  cidr_blocks = [
    # Windows Client Private IP Address
    "${var.private_ip_windows_client}/32",
  ]
}

resource "aws_security_group_rule" "proxy_server_in_https" {
  security_group_id = aws_security_group.proxy_server_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  description = "from Windows Client"

  cidr_blocks = [
    # Windows Client Private IP Address
    "${var.private_ip_windows_client}/32",
  ]
}

resource "aws_security_group_rule" "proxy_server_out_all" {
  security_group_id = aws_security_group.proxy_server_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
