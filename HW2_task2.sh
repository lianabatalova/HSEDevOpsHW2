#!/bin/bash
#get number of rows
ROWS=$(cat $1 | wc -l)
#get number of rows without header
ROWS_WO_HEADER=$(expr $ROWS - 1)
#count numbr of train rows
LINES_TRAIN=$(($ROWS_WO_HEADER*$2/100+1))
NOW=`date +"%Y-%m-%d-%s"`
#write split data to files
sed -n -e "2,$LINES_TRAIN p" -e "$LINES_TRAIN q" $1 >> train_${NOW}.csv
sed -n -e "$(expr $LINES_TRAIN + 1),$ROWS_WO_HEADER p" -e "$ROWS_WO_HEADER q" $1 >> val_${NOW}.csv
