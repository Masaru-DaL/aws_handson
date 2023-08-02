# -----------------------------
# IAM Role for EC2
# -----------------------------
resource "aws_iam_role" "iam_role_for_ec2" {
  name               = "IAMRoleForEC2"
  description        = "IAM Role for EC2"
  assume_role_policy = data.aws_iam_policy_document.assume_role_for_ec2.json
}

resource "aws_iam_instance_profile" "iam_instance_profile_for_ec2" {
  name = aws_iam_role.iam_role_for_ec2.name
  role = aws_iam_role.iam_role_for_ec2.id
}

resource "aws_iam_policy" "allow_list_policy_for_ec2" {
  name        = "AllowListPolicyForEC2"
  description = "Policy to allow EC2 access to S3, CloudWatch Logs"
  policy      = data.aws_iam_policy_document.allow_list_for_ec2.json
}

resource "aws_iam_role_policy_attachment" "allow_list_policy_attachment_for_ec2" {
  role       = aws_iam_role.iam_role_for_ec2.name
  policy_arn = aws_iam_policy.allow_list_policy_for_ec2.arn
}

# -----------------------------
# IAM Role for Cloud9
# -----------------------------
resource "aws_iam_role" "iam_role_for_cloud9" {
  name               = "IAMRoleForCloud9"
  description        = "IAM Role for Cloud9"
  assume_role_policy = data.aws_iam_policy_document.assume_role_for_cloud9.json
}

resource "aws_iam_instance_profile" "iam_instance_profile_for_cloud9" {
  name = aws_iam_role.iam_role_for_cloud9.name
  role = aws_iam_role.iam_role_for_cloud9.id
}

resource "aws_iam_policy" "allow_list_policy_for_cloud9" {
  name        = "AllowListPolicyForCloud9"
  description = "Policy to allow Cloud9 access to S3"
  policy      = data.aws_iam_policy_document.allow_list_for_cloud9.json
}

resource "aws_iam_role_policy_attachment" "allow_list_policy_attachment_for_cloud9" {
  role       = aws_iam_role.iam_role_for_cloud9.name
  policy_arn = aws_iam_policy.allow_list_policy_for_cloud9.arn
}
