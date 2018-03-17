#!/bin/bash

# For creating intermediate result file to be used later with add.awk

HM=$HOME/ranking
scripts=$HM/scripts
ranker=the
pre=MM_THE


for input in `ls $HM/html/$pre*`
do
    # Setting defaults
    name=`basename $input | cut -d'.' -f1`
    filtered="$HOME/ranking/$name""_filtered.html"
    uni="$HOME/ranking/$name""_uni.txt"
    rank="$HOME/ranking/$name""_rank.txt"
    score="$HOME/ranking/$name""_score.txt"
    final="$HOME/ranking/$name"
    final2="$HOME/ranking/"$ranker"_result/$name"
    tmp="/tmp/score"
    score_all="$HOME/ranking/$name""_score_all"

    echo "Processing $input"
    $scripts/"$ranker"_extract.sh -i $input
    $scripts/"$ranker"_compute.awk $score_all > $tmp
    $scripts/"$ranker"_add.awk $tmp $final > $final2
    rm $final $score_all $tmp
done

$scripts/"$ranker"_result.awk $HM/"$ranker"_result/* | sort -nr > $HM/"$ranker"_result/"$pre"_final
