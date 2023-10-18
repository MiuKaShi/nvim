#!/bin/bash

# Define a list of dictionaries
# CET: CET4&6 words
# GRE: 800 GRE words
# STU: My  words

dic_list=(
    "_EN.txt"
    "_TEC.txt"
)

# Merge all word lists into one file
sort -u "${dic_list[@]}" >sorted_words.txt


# convert to lowercase
tr '[:upper:]' '[:lower:]' < sorted_words.txt > words.txt

# remove ^M
rm -f sorted_words.txt && sed -i -e "s/\r//g" words.txt
