#!/bin/bash
source ../docker/.env

# Mac SED issues : sed: RE error: illegal byte sequence
# see : https://stackoverflow.com/questions/19242275/re-error-illegal-byte-sequence-on-mac-os-x
export LC_CTYPE=C
export LANG=C

source_domain=$LOCAL_DOMAIN
target_domain=$LIVE_DOMAIN

if [ -z "$1" ]
  then
    echo "Need to pass in the filename.sql in the data_out folder"
    echo "This replaces $source_domain to $target_domain, making sql ready for export to live db"
    exit 1
fi

dir_path="../data_out/"
source_path=${dir_path}${1}
target_path=${source_path//'.sql'/'_out.sql'}

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
    sed -i '' "s/http:\/\/$source_domain/http:\/\/$target_domain/g" $target_path;
    sed -i '' "s/$source_domain/$target_domain/g" $target_path;
    echo "data out sql at : $target_path";
else
    echo "no result, exiting"
fi
