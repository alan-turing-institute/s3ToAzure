# s3ToAzure

This simple tool provides a way of directly transferring data from an Amazon Web Services S3 bucket to Azure Blob Storage.

## Required Permissions

The following permissions are required on AWS:

`s3:ListBucket` for Amazon S3 Bucket Operations, in order to list the files inside of a bucket.
`s3:GetObject` for Amazon S3 Object Operations

## Prerequisites

Install the Microsoft Azure command line tools: https://github.com/Azure/azure-cli
Install the Amazon Web Services command line tools: http://docs.aws.amazon.com/cli/latest/userguide/installing.html

Configure the AWS CLI by typing `aws configure` and entering your credentials
Login to the Azure CLI by typing `az login`

## Usage

1. Get a list of files from the desired S3 bucket, replace `<S3 FILE LIST>` with the desired file name

```bash
$ aws s3 ls s3://<S3 BUCKET NAME>  | tr -s ' ' | cut -d ' ' -f4 > <S3 FILE LIST>
```

2. Run the `parallel_download.sh` script

```bash
$ bash parallel_download.sh -i <S3 FILE LIST> -w <NUMBER OF PARALLEL CONNECTIONS> -n <AZURE STORAGE NAME> -k <AZURE STORAGE KEY> -c <AZURE CONTAINER NAME>
```
