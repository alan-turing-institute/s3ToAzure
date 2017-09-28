#!/bin/bash

while getopts i:w:n:k:c:r: option
do
    case "${option}"
    in
        i) file_list_path=${OPTARG};;
        w) workers=${OPTARG};;
        n) azure_storage_name=${OPTARG};;
        k) azure_storage_key=${OPTARG};;
        c) azure_container_name=$OPTARG;;
        r) aws_container_name=${OPTARG};;
    esac
done

lines=`wc -l < $file_list_path`
files_per_worker=`expr $lines / $workers`
directory="tmp/$azure_container_name"

# Remove everything in temporary directory
rm $directory/*

# Create directory if not exist
mkdir -p $directory

split -l $files_per_worker $file_list_path $directory/$azure_container_name

files=`ls $directory`

for file in $files; do
    screen -dmS $file ./s3ToAzure.sh -i $directory/$file -n $azure_storage_name -k $azure_storage_key -c $azure_container_name -r $aws_container_name
done

screen -ls
