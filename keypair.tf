# -----------------------------
# Key Pair
# -----------------------------
resource "aws_key_pair" "keypair" {
  key_name   = "${var.project}-${var.environment}-keypair"
  public_key = file("${var.ssh_public_key}")

  tags = {
    Environment = "${var.project}-${var.environment}-keypair"
    Project     = var.project
    Env         = var.environment
  }
}
