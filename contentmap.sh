#!/bin/bash
# By:   	Chris Hughes
# On:		8 July 2015
# Edited By: 	Chris Hughes
# Edited On:	21 July 2015 - Removed "s from results

grep  v\= access.log |  awk '{print $1, $7, $11, $NF}' | awk -FS"?v=" '{print $1,"\t", $2}' >> stage1.txt
cat stage1.txt | awk -F'[&]' '{print $1, $2, $NF}' | awk '{print $1,",", $3,",", $6,",", $NF}' >> mappedcontent.csv
sed 's/\"//g' mappedcontent.csv
rm -f stage1.txt
