#!/bin/sh

command -v php >/dev/null 2>&1 || { echo "PHP not found"; exit 1; }

mv ./static.sh /tmp/static.sh
mv ./directory-listing.patch /tmp/directory-listing.patch

curl -o /tmp/directory-listing.php https://raw.githubusercontent.com/caendesilva/php-directory-listing/master/directory-listing.php

patch /tmp/directory-listing.php /tmp/directory-listing.patch 

find . -type d ! -path "*/.git*" | while IFS= read -r dir; do
    echo "Running in $dir"
    (cd "$dir" && php /tmp/directory-listing.php)
done

