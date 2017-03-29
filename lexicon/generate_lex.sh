#!/bin/bash

cat NLSPARQL.train.data | cut -f 1 | sed '/^ *$/d' | sort | uniq -c | sed 's/^ *//g' | awk '{OFS="\t"; print $2,$1}' > lex.txt