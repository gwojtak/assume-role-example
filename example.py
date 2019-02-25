#!/usr/bin/env python
# -*- coding: utf-8 -*-

import boto3

def main():
    sts = boto3.('sts')
    creds = sts.assume_role(
        RoleArn="arn:aws:iam::0123456789AB:role/wojtak-bucket-testing",
        RoleSessionName="AnArbitraryString"
    )

    s3 = boto3.client(
        's3',
        aws_access_key_id=creds['Credentials']['AccessKeyId'],
        aws_secret_access_key=creds['Credentials']['SecretKeyId'],
        aws_session_token=creds['Credentials']['SessionToken']
    )

    print(s3.list_buckets())
    print(s3.list_objects(Bucket="wojtak")

if "__main__" == __name__:
    main()
