#!/bin/bash

data_csv=$4
folder_name=$3
col_name=$2
col_name=$(head -1 $data_csv | tr -s ';' '\n' | nl -nln |  grep "$col_name" | cut -f1)
echo $col_name 
links=$(awk -F ";" -v head=$col_name '{print $head}' $data_csv)
mkdir -p $folder_name
cd $folder_name

workers_count=$1
workers_pool=$workers_count
echo $workers_count

for link in $links
do
if [ $workers_pool -eq 0 ]
then
    wait
    workers_pool=$workers_count
fi
    workers_pool="$(($workers_pool-1))"
    echo $workers_pool
    echo $link
    wget $link &
done
wait