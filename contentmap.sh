#!/bin/bash
# contentmap.sh
# By:   	Chris Hughes
# On:		8 July 2015
# Edited By: 	Chris Hughes
# Edited On:	22 July 2015 


grep v\= access.log | grep -v "\"\-\"" | awk '{print $7, $11, $NF}' | awk -FS"?v=" '{print $1,"\t", $2}' | awk -F'[&]' '{print  $1 $2 $3 $NF}' | awk '{print $2 $3 $NF}' | awk '{print $2 $3 $NF}' | sed 's/\=/ /g' | sed 's/\"/ /g' |  grep v\= access.log | grep -v "\"\-\"" | awk '{print $7, $11, $NF}' | awk -FS"?v=" '{print $1,"\t", $2}' | awk -F'[&]' '{print  $1 $2 $3 $NF}' | awk '{print $2 $3 $NF}' | awk '{print $2 $3 $NF}' | sed 's/\=/ /g' | sed 's/\"/ /g' | sed 's/\// /g' |  awk -F\/ '{print $1 $2 $3 $NF}' | sed 's/https://g' | awk '{print $1","$5","$NF}' | grep -v errata | sed 's/s//' | sort -u > `date +"%Y%m%d_%H%M%S"`_contentmap.csv

exit

