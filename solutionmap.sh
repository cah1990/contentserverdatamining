#!/bin/bash
# By:   	Chris Hughes
# On:		21 July 2015
# Edited By:
# Edited On:
# Pulls the Solutions Bundle and requesting IP from the Content Server access logs.
# Requests that don't contain data in each of these fields are dropped.  This list also shows only unique results.

#rm -f solstage1.txt solstage2.txt solstage3.txt mappedsolutions.csv
#grep "GET /files/published" access.log |  awk '{print $7, $NF}' > solstage1.txt
#cat solstage1.txt | awk -F/ '{print $4, $NF }' | awk '{print $1, $NF}'| uniq > solstage2.txt
#sed 's/\"//g' solstage2.txt > solstage3.txt
#cat solstage3.txt |grep -v "-" | awk '{print $1,",",$2}'| sort -u  > mappedsolutions.csv
#rm -f solstage1.txt solstage2.txt

grep "GET /files/published/"  access.log | awk '{print $1,$7, $11, $NF}' | grep -v "\"\-\"" | awk -F/ '{print $1","$4","$8","$9}' | sed 's/\"//g' | sort -u > mappedsolutions.csv



exit
