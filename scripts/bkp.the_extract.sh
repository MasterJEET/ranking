#!/bin/bash


input=$1

hxnormalize -x -e -d -L < $input | hxselect 'tr[data-nid]' | hxnormalize -x -e -d -L
