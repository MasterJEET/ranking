#!/bin/bash


HM=$HOME/ranking
scripts=$HM/scripts


for input in `ls $HM/html/the*`
do
    # Setting defaults
    name=`basename $input | cut -d'.' -f1`
    filtered="$HOME/ranking/$name""_filtered.html"
    uni="$HOME/ranking/$name""_uni.txt"
    rank="$HOME/ranking/$name""_rank.txt"
    score="$HOME/ranking/$name""_score.txt"
    final="$HOME/ranking/$name"
    final2="$HOME/ranking/the_result/$name"
    tmp="/tmp/score"
    score_all="$HOME/ranking/$name""_score_all"

    echo "Processing $input"
    $scripts/the_extract.sh -i $input
    $scripts/the_compute.awk $score_all > $tmp
    $scripts/the_add.awk $tmp $final > $final2
    rm $final $score_all $tmp
done

$scripts/the_result.awk $HM/the_result/* | sort -nr > $HM/the_result/the_final
