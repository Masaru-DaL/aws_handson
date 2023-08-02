# -----------------------------
# S3
# -----------------------------
resource "aws_s3_bucket" "s3" {
  bucket = "${var.project}-${var.environment}-s3"

  tags = {
    Name    = "${var.project}-${var.environment}-s3"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_lifecycle" {
  bucket = aws_s3_bucket.s3.id

  rule {
    id     = "overwrite-objects"
    status = "Enabled"

    transition {
      days          = 30 # STANDARD_IAに移行するまでの日数
      storage_class = "STANDARD_IA"
    }

    expiration {
      days = 3650 # オブジェクトを削除しない
    }
  }
}

resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.s3.id

  versioning_configuration {
    # status = "Enabled"
    status = "Suspended"
  }
}

# ローカル値を定義する
locals {
  s3_upload_dir = "${path.module}${var.s3_upload_dir}"
}

# /src/uploadディレクトリ内の全てのファイルを検出し、それぞれに対してlocal_fileデータソースを作成する
data "local_file" "upload_files" {
  for_each = fileset(local.s3_upload_dir, "**/*")
  filename = "${local.s3_upload_dir}/${each.value}"
}

resource "aws_s3_bucket_object" "file_object" {
  for_each = data.local_file.upload_files
  bucket   = aws_s3_bucket.s3.bucket
  key      = each.key
  source   = each.value.filename
  acl      = "private"

  # Destroy時にオブジェクトを削除しない
  lifecycle {
    prevent_destroy = true
  }
}
