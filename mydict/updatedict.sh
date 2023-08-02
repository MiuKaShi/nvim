#!/bin/bash

# Define a list of dictionaries
# CET: CET4&6 words
# GRE: 800 GRE words
# STU: My  words

dic_list=(
    "_CET.txt"
    "_GRE.txt"
    "_TEC.txt"
)

# Merge all word lists into one file
cat "${dic_list[@]}" >all_words.txt

# Sort the words and remove duplicates
sort all_words.txt | uniq >words.txt && rm all_words.txt
