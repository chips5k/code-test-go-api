#bin/bash
sha=$1
branch=$2
number=$3
workflow=$4
image=go-api:$branch:$number
datetime=$(date '+%Y-%m-%d %H:%M:%S %Z %z');
sed -i.bk -e "s/\${sha}/$sha/;s/\${branch}/$branch/;s/\${number}/$number/;s/\${workflow}/$workflow/;s/\${image}/$image/;s/\${datetime}/$datetime/" meta.json