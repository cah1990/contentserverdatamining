#!/bin/bash
# solutionmap.sh
# By:   	Chris Hughes
# On:		21 July 2015
# Edited By:
# Edited On:
# Pulls the Solutions Bundle and requesting IP from the Content Server access logs.
# Requests that don't contain data in each of these fields are dropped.  This list also shows only unique results.

grep "GET /files/published/"  access.log | awk '{print $7, $11, $NF}'| grep -v "\"\-\"" | sed 's/\"//g' | sed 's/https:\/\// /g' | sed 's/\// /g' | awk '{print $3","$6","$NF}'| grep -v errata | sort -u > `date +"%Y%m%d_%H%M%S"`_solutionmap.csv
 
exit
