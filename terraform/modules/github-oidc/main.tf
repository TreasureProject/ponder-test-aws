data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

resource "aws_iam_role" "ponder_github_oidc" {
  name               = "${var.prefix}-github-actions"
  path               = "/"
  assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Federated": "arn:aws:iam::${local.account_id}:oidc-provider/token.actions.githubusercontent.com"
                },
                "Action": "sts:AssumeRoleWithWebIdentity",
                "Condition": {
                    "StringEquals": {
                        "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
                    },
                    "StringLike": {
                        "token.actions.githubusercontent.com:sub": "repo:${var.github_project}:*"
                    }
                }
            }
        ]
    }
  EOF
  inline_policy {
    name   = "github_actions"
    policy = data.aws_iam_policy_document.github_oidc.json
  }
}

resource "aws_iam_role_policy_attachment" "eb_managed_update" {
  role       = aws_iam_role.ponder_github_oidc.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy"
}

resource "aws_iam_role_policy_attachment" "eb_web_tier" {
  role       = aws_iam_role.ponder_github_oidc.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

# IAM Role Policy
data "aws_iam_policy_document" "github_oidc" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:CompleteLayerUpload",
      "ecr:GetAuthorizationToken",
      "ecr:UploadLayerPart",
      "ecr:InitiateLayerUpload",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "iam:PassRole"
    ]
    resources = ["*"]
  }
}
