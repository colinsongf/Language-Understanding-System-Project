#!/bin/bash
# @author Federico Marinelli

# -- GENERATE ONE SINGLE LEXICON --
# Input: NLSPARQL.train.data && NLSPARQL.train.feats.txt

cat ../data/NLSPARQL.train.data | cut -f 1 > tmp.txt
cat ../data/NLSPARQL.train.data | cut -f 2 >> tmp.txt
cat ../data/NLSPARQL.train.feats.txt | cut -f 2 -f 3 | tr '\t' '#' >> tmp.txt
cat ../data/NLSPARQL.train.feats.txt | cut -f 2 >> tmp.txt
cat ../data/NLSPARQL.train.feats.txt | cut -f 3 >> tmp.txt

cat tmp.txt | tr ' ' '\n' | sed '/^ *$/d' | sort | uniq > tmp2.txt



COUNTER=1
while read p; do
	echo "$p\t$COUNTER";
	COUNTER=$((COUNTER + 1));
done < tmp2.txt > lexicon.txt
echo "<unk>\t$COUNTER" >> lexicon.txt
echo "<epsilon>\t0" | cat - lexicon.txt > temp && mv temp lexicon.txt

rm tmp.txt
rm tmp2.txt
