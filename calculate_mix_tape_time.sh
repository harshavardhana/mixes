#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Please provide a mix file.. exit"
    echo "Usage: $0 <mix_file>"
    exit
fi

minute_series=$(cut -f3 -d- $1  | cut -f1 -d: | tr '\n' ' ')
second_series=$(cut -f3 -d- $1  | cut -f2 -d: | tr '\n' ' ')

j=0
for i in $(echo $minute_series); do
    j=$(expr $i + $j)
done

k=0
for l in $(echo $second_series); do
    k=$(expr $l + $k)
done


if [ $k -ge 60 ]; then
    sec_mins=$(echo "scale=2; $k / 60" | bc -l)
else
    sec_mins=$k
fi

mix_time=$(echo "$j + $sec_mins" | bc -l)
echo "Total mix time: $mix_time"