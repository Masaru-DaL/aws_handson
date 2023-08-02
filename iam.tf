# -----------------------------
# IAM Role for EC2
# -----------------------------
data "aws_iam_policy_document" "assume_role_for_ec2" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam_role_for_ec2" {
  name               = "IAMRoleForEC2"
  description        = "IAM Role for EC2"
  assume_role_policy = data.aws_iam_policy_document.assume_role_for_ec2.json
}

resource "aws_iam_instance_profile" "iam_instance_profile_for_ec2" {
  name = aws_iam_role.iam_role_for_ec2.name
  role = aws_iam_role.iam_role_for_ec2.id
}

data "aws_iam_policy_document" "allow_list_for_ec2" {
  # S3 GetObject Policy
  statement {
    actions = [
      "s3:GetObject",
    ]
    resources = ["${aws_s3_bucket.s3.arn}/*"]
  }

  # # SSM GetParameter Policy
  # statement {
  #   actions = [
  #     "ssm:GetParameter",
  #   ]
  #   resources = ["*"]
  # }

  # CloudWatch Logs Policy
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutRetentionPolicy",
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
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
data "aws_iam_policy_document" "assume_role_for_cloud9" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam_role_for_cloud9" {
  name               = "IAMRoleForCloud9"
  description        = "IAM Role for Cloud9"
  assume_role_policy = data.aws_iam_policy_document.assume_role_for_cloud9.json
}

resource "aws_iam_instance_profile" "iam_instance_profile_for_cloud9" {
  name = aws_iam_role.iam_role_for_cloud9.name
  role = aws_iam_role.iam_role_for_cloud9.id
}

data "aws_iam_policy_document" "allow_list_for_cloud9" {
  # S3 GetObject Policy
  statement {
    actions = [
      "s3:GetObject",
    ]
    resources = ["${aws_s3_bucket.s3.arn}/*"]
  }
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
