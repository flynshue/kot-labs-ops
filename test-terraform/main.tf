resource "aws_iam_user" "test-s3" {
  name = "test-s3-user"
}

resource "aws_iam_access_key" "test-s3" {
  user = aws_iam_user.test-s3.name
}

data "aws_iam_policy_document" "test-s3" {
  statement {
    effect = "Allow"

    actions = [
      "s3:AbortMultipartUpload",
      "s3:DeleteObject",
      "s3:DeleteObjectTagging",
      "s3:DeleteObjectVersion",
      "s3:DeleteObjectVersionTagging",
      "s3:Get*",
      "s3:List*",
      "s3:ListAllMyBuckets",
      "s3:PutObject*",
      "s3:RestoreObject",
      "s3:CreateBucket",
      "s3:ListBucket",
      "s3:PutBucketAcl",
      "s3:GetLifecycleConfiguration",
      "s3:PutLifecycleConfiguration",
    ]

    resources = [
      "arn:aws:s3:::kot-labs-*/*",
      "arn:aws:s3:::kot-labs-*",
    ]
  }
}

resource "aws_iam_user_policy" "test-s3" {
  name   = "test-s3-user"
  policy = data.aws_iam_policy_document.test-s3.json
  user   = aws_iam_user.test-s3.name
}

resource "aws_s3_bucket" "kot-labs" {
  for_each = toset(var.kot-labs-buckets)
  bucket = each.key
}

resource "aws_s3_object" "test-objects" {
  for_each = toset(var.kot-labs-buckets)
  bucket = each.key
  key = "${each.key}-file"
  content = "${each.key}-file-content"
}

output "access_key" {
  value = aws_iam_access_key.test-s3.encrypted_secret
}
