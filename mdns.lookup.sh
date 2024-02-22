#!/bin/bash

$DIR=$1 

egrep -ro '[a-zA-Z0-9-]+.local' $DIR | cut -d : -f 2 | sort | uniq | while read host; do
  resolvectl query ${host} -4 --legend=no | sed 's/:/ /g' | awk '{print $2, $1}';
done

