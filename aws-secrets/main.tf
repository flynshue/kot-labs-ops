data "aws_caller_identity" "current" {}


resource "aws_iam_user" "user" {
  name = var.username
}

data "aws_iam_policy_document" "secrets_policy" {
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:C*",
      "secretsmanager:D*",
      "secretsmanager:U*",
      "secretsmanager:L*",
      "secretsmanager:G*",
      "secretsmanager:P*",
      "secretsmanager:RotateSecret",
      "secretsmanager:RestoreSecret",
      "secretsmanager:T*",
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/Application"
      values = [
        "kot-labs",
      ]
    }
  }
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:C*",
      "secretsmanager:D*",
      "secretsmanager:U*",
      "secretsmanager:L*",
      "secretsmanager:G*",
      "secretsmanager:P*",
      "secretsmanager:RotateSecret",
      "secretsmanager:RestoreSecret",
      "secretsmanager:T*",
    ]
    resources = ["arn:aws:secretsmanager:*:${data.aws_caller_identity.current.account_id}:secret:${var.team_name}*"]
  }
}

data "aws_iam_policy_document" "list_secrets" {
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:L*",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "secrets_policy" {
  name   = "${var.username}_secrets_policy"
  policy = data.aws_iam_policy_document.secrets_policy.json
}

resource "aws_iam_policy" "list_secrets_policy" {
  name   = "${var.username}_list_secrets_policy"
  policy = data.aws_iam_policy_document.list_secrets.json
}

resource "aws_iam_user_policy_attachment" "secrets_policy" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.secrets_policy.arn
}

resource "aws_iam_user_policy_attachment" "list_secrets_policy" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.list_secrets_policy.arn
}

# Create the access key first using aws cli and then import
# i.e terraform import aws_iam_access_key.key AKIASXLLF3LHKL2PAY6P
resource "aws_iam_access_key" "key" {
  user = aws_iam_user.user.name
}