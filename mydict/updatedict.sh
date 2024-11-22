#!/bin/bash

# Define a list of dictionaries
# CET: CET4&6 words
# GRE: 8000 GRE words
# USER: User words

dic_list=(
    "_CET.txt"
    "_GRE.txt"
    "_USER.txt"
)

# Preprocessing user words
cat _USER.txt | awk 'NF > 0' | sort -u >temp_file && mv temp_file _USER.txt

# Merge and deduplication all word lists into one file
sort -u "${dic_list[@]}" | sed -e "s/\r//g" >words.txt
