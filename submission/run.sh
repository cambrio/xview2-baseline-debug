#!/bin/bash

# Debug version

# Running inference using CLI arguments passed in
# 1) path to xview2-baseline 
# 2) path to input pre image 
# 3) path to input post image 
# 4) path to output localization image 
# 5) path to output localization+classification image

set -euxo pipefail

echo "### BEGIN DEBUG ###"
echo "### v32"

ls -l
ls -l /tmp

### DEBUG
vmstat -s
cat /proc/meminfo
#cat /proc/cpuinfo # careful, can be up to 96 CPUs, lots of info
# top -b -n 1 > /tmp/top.log
# cat /tmp/top.log
df -h

echo "### END DEBUG ###"

if [ $# -lt 5 ]; then 
        echo "run.sh: /path/to/xview2-baseline/ /path/to/input/pre/image /path/to/input/post/image /path/to/localization/output/image /path/to/classification/output/image" 
else
    "$1"/utils/inference.sh -x "$1" -i "$2"  -p "$3" -o "$4"  -l "$1"/weights/localization.h5 -c "$1"/weights/classification.hdf5 -y

    echo "DEBUG list path args:"
    ls -l $1
    ls -l $2
    ls -l $3
    ls -l $4
    ls -l $5
    
    # The two images we will use for scoring will be identical so just copying the output localization png to the classification path 
    cp "$4" "$5"
fi
