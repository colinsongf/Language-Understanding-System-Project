#!/bin/bash
# @author Federico Marinelli

# -- GENERATE ONE SINGLE LEX FROM NLSPARQL.train.data --

cat ../data/NLSPARQL.train.data | cut -f 1 | tr ' ' '\n' | sed '/^ *$/d' | sort | uniq >  tmp.txt
cat ../data/NLSPARQL.train.data | cut -f 2 | tr ' ' '\n' | sed '/^ *$/d' | sort | uniq >> tmp.txt

COUNTER=1
while read p; do
	echo "$p\t$COUNTER";
	COUNTER=$((COUNTER + 1));
done < tmp.txt > lexicon.txt
echo "<unk>\t$COUNTER" >> lexicon.txt
echo "<espilon>\t0" | cat - lexicon.txt > temp && mv temp lexicon.txt

rm tmp.txt
