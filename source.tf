data "aws_iam_policy_document" "assumer" {
  statement {
    sid     = "assumer"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      #      type        = "AWS"
      #      identifiers = ["${aws_iam_role.s3_access.arn}"]
      type = "Service"

      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "assumer" {
  name               = "wojtak-bucket-access-assumer"
  description        = "using for testing access to wojtak bucket"
  assume_role_policy = "${data.aws_iam_policy_document.assumer.json}"
}

resource "aws_iam_instance_profile" "assumer" {
  name = "wojtak-bucket-access-assumer"
  role = "${aws_iam_role.assumer.name}"
}
