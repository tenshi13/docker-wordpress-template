#!/bin/bash
source ../docker/.env

if [ -z "$1" ]
  then
    echo "Need to pass in the path to file as a parameter"
    exit 1
fi

dir_path="../data_in/"
source_path=${dir_path}${1}
target_path=${source_path//'.sql'/'_in.sql'}

source_domain=$LIVE_DOMAIN
target_domain=$LOCAL_DOMAIN

if [ ! -f "$source_path" ]; then
    echo "$source_path does not exist"
    exit 1
fi

echo "Searching $source_domain in $source_path"
ccount=$(grep -c "$source_domain" $source_path)
echo "Count : $ccount"
if [ $ccount -gt 0 ]
then
    sed 's/https:\/\/$source_domain/https:\/\/$target_domain/g' $source_path > $target_path;
    sed -i '' "s/http:\/\/$source_domain/http:\/\/$target_domain/g" $target_path
    sed -i '' "s/$source_domain/$target_domain/g" $target_path
    echo "data in sql at : $target_path"
else
    echo "no result, exiting"
fi
