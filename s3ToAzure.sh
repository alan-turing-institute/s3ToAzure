#!/bin/bash

while getopts i:w:n:k:c option
do
    case "${option}"
    in
        i) fileslist=${OPTARG};;
        n) azure_storage_name=${OPTARG};;
        k) azure_storage_key=${OPTARG};;
        c) azure_container_name=$OPTARG;;
    esac
done

echo "Getting names of files"
files=`cat $1`
i=0
total_files=`wc -l $1`

start_date_time="`date +%Y%m%d%H%M%S`";

for file in $files; do
    echo "Uploading the file..."
    az storage blob copy start --source-uri https://s3.eu-west-2.amazonaws.com/$azure_container_name/$file --destination-blob $file --destination-container weather --account-key $azure_storage_key --account-name $azure_storage_name  > /dev/null
    i=`expr $i + 1`
    echo "Total Files Uploaded $i / $total_files"
    current_date_time="`date +%Y%m%d%H%M%S`";
    echo $current_date_time;
done

echo "Files in the Azure container"
az storage blob list --container-name $azure_container_name --output table

current_date_time="`date +%Y%m%d%H%M%S`";
echo "start date: $start_date_time";
echo "end date: $current_date_time";
