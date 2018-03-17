#!/bin/bash

#########################
# Extract data
# @author: MasterJEET
# @email : masterjeet9@gmail.com
#########################


# Help message

help(){
    echo "NAME
    $0 - Extract data from html

SYNOPSIS
    $0 -i in [-o out]
    
OPTIONS
    -i in
        Specify input file as \"in\"
    -o out
        Specify output file as \"out\""
    exit
}


# Command line arguments parsing

while [ $# -gt 1 ]; do
key="$1"
val="$2"
    
    case $key in
        -i)
            input="$val"
            shift
            shift
            ;;
        -o)
            filtered="$val"
            shift
            shift
            ;;
        *)
            echo "$key not recognized. See help below
            "
            help    
    esac
done

[[ -z "$input" ]] && help

# Setting defaults
name=`basename $input | cut -d'.' -f1`
filtered="$HOME/ranking/$name""_filtered.html"
uni="$HOME/ranking/$name""_uni.txt"
rank="$HOME/ranking/$name""_rank.txt"
score="$HOME/ranking/$name""_score.txt"
final="$HOME/ranking/$name"
score_all="$HOME/ranking/$name""_score_all"
sep="_#_"



################################## Main program #######################################
#######################################################################################

# Filtering & normalizing original html for further processing
grep "td-wrap-in" $input | hxnormalize -x -e -d | hxselect td | hxnormalize -x -e -d | sed 's/ rank/rank/g' | sed 's/ uni/uni/g' > $filtered
[[ $? -eq 0 ]] && echo "Filtered output"

# Exrtacting university list
hxselect 'td[data-dt-row]' < $filtered | hxselect a | tr -d '\n' | sed 's/a>/a>\n/g' | sed 's/ \+/ /g' | hxselect a -c -s '\n' > $uni
[[ $? -eq 0 ]] && echo "University list extracted"

# Extracting university ranking
hxselect 'td[data-dt-row]' < $filtered | hxselect 'span.rank' -c -s '\n' | sed 's/[^0-9,-]*//g' > $rank
[[ $? -eq 0 ]] && echo "Ranking extracted"

# Extracting scores of each university
hxselect 'td.sorting_2' < $filtered | hxselect 'div.td-wrap-in' -c -s '\n' > $score
[[ $? -eq 0 ]] && echo "Scores extracted"

echo "#Scores" > $score_all
hxselect 'div.td-wrap-in' -s '\n' < $filtered | grep -E '<div class="td-wrap-in">[0-9]*\.*[0-9]*</div>' | hxselect 'div.td-wrap-in' -c -s '\n' | while read -r one; do
    read -r two; read -r three; read -r four; read -r five
    echo "$one$sep$two$sep$three$sep$four$sep$five" >> $score_all
    #read -r two; read -r three; read -r four; read -r five; read -r six; read -r seven
    #echo "$one$sep$two$sep$three$sep$four$sep$five$sep$six$sep$seven" >> $score_all
    #read -r two; read -r three; read -r four; read -r five; read -r six; read -r seven; read -r ei; read -r ni; read -r te; read -r el; read -r tw
    #echo "$one$sep$two$sep$three$sep$four$sep$five$sep$six$sep$seven$sep$ei$sep$ni$sep$te$sep$el$sep$tw" >> $score_all
done

# Putting all info in one file
echo "Ranking$sep""University$sep""Score" > $final

while read r <&3 && read u <&4 && read s <&5; do
    echo "$r$sep$u$sep$s" >> $final
done 3<$rank 4<$uni 5<$score

rm $filtered $rank $uni $score
#rm $rank $uni $score

echo "Data stored in $final"
