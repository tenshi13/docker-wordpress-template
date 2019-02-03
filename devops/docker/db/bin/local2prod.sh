#!/usr/bin/env bash
source config.sh

if [ -z "$1" ]
  then
    echo "Need to pass in the path to file as a parameter"
    exit 1
fi

echo "Searching $dev_url in $1"
ccount=$(grep -c "$dev_url" $1)
echo "Count : $ccount"
if [ $ccount -gt 0 ]
then
    sed -i "" -e "s/http:\/\/$dev_url/http:\/\/$prod_url/pg" $1
    sed -i "" -e "s/$dev_url/$prod_url/pg" $1
else
    echo "no result, exiting"
fi
