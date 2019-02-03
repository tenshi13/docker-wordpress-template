#!/usr/bin/env bash
source config.sh

if [ -z "$1" ]
  then
    echo "Need to pass in the path to file as a parameter"
    exit 1
fi


echo "Searching $prod_url in $1"
ccount=$(grep -c "$prod_url" $1)
echo "Count : $ccount"
if [ $ccount -gt 0 ]
then
    sed -i "" -e "s/http:\/\/$prod_url/http:\/\/$dev_url/pg" $1
    sed -i "" -e "s/$prod_url/$dev_url/pg" $1
else
    echo "no result, exiting"
fi
