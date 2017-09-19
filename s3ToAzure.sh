#!/bin/bash

while getopts i:n:r:k:c: option
do
    case "${option}"
    in
        i) filelist=${OPTARG};;
        n) azure_storage_name=${OPTARG};;
        k) azure_storage_key=${OPTARG};;
        c) azure_container_name=${OPTARG};;
        r) aws_container_name=${OPTARG};;
    esac
done

echo "Getting names of files"
files=`cat $filelist`
i=0
total_files=`wc -l < $filelist`

start_date_time="`date +%Y%m%d%H%M%S`";

for path in $files; do
    echo az storage blob copy start --source-uri https://${aws_container_name}.s3.amazonaws.com/$path --destination-blob $path --destination-container $azure_container_name --account-key $azure_storage_key --account-name $azure_storage_name
    echo "Uploading the file..."
    az storage blob copy start --source-uri https://${aws_container_name}.s3.amazonaws.com/$path --destination-blob $path --destination-container $azure_container_name --account-key $azure_storage_key --account-name $azure_storage_name
    i=`expr $i + 1`
    echo "Total Files Uploaded $i / $total_files"
    current_date_time="`date +%Y%m%d%H%M%S`";
    echo $current_date_time;
done

echo "Files in the Azure container"
az storage blob list --container-name $azure_container_name --account-key $azure_storage_key --account-name $azure_storage_name --output table

current_date_time="`date +%Y%m%d%H%M%S`";
echo "start date: $start_date_time";
echo "end date: $current_date_time";
