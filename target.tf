data "aws_iam_policy_document" "s3_access" {
  statement {
    sid       = "s3"
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = ["${format("%s/*", data.aws_s3_bucket.wojtak.arn)}"]
  }

  statement {
    sid       = "s3Buckets"
    effect    = "Allow"
    actions   = ["s3:ListBucket", "s3:HeadBucket", "s3:ListAllMyBuckets"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "allower" {
  statement {
    sid     = "allower"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      #type        = "Service"
      #      identifiers = ["ec2.amazonaws.com"]
      type = "AWS"

      identifiers = ["${aws_iam_role.assumer.arn}"]
    }
  }
}

resource "aws_iam_policy" "s3_access" {
  name        = "wojtak-access"
  description = "Using for testing access to wojtak bucket"
  policy      = "${data.aws_iam_policy_document.s3_access.json}"
}

resource "aws_iam_role" "s3_access" {
  name               = "wojtak-bucket-testing"
  description        = "using for testing access to wojtak bucket"
  assume_role_policy = "${data.aws_iam_policy_document.allower.json}"
}

resource "aws_iam_role_policy_attachment" "s3_attach" {
  role       = "${aws_iam_role.s3_access.name}"
  policy_arn = "${aws_iam_policy.s3_access.arn}"
}

output "s3_access_role_arn" {
  value = "${aws_iam_role.s3_access.arn}"
}
