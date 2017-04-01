#!/bin/bash
# @author Federico Marinelli

# -- GENERATE TWO DISTINCT LEX FROM NLSPARQL.train.data -- #

cat ../data/NLSPARQL.train.data | cut -f 1 | tr ' ' '\n' | sed '/^ *$/d' | sort | uniq >  tmp.txt
COUNTER=1
while read p; do
echo "$p\t$COUNTER";
COUNTER=$((COUNTER + 1));
done < tmp.txt > lex_words.txt
echo "<unk>\t$COUNTER" >> lex_words.txt
echo "<espilon>\t0" | cat - lex_words.txt > temp && mv temp lex_words.txt

cat ../data/NLSPARQL.train.data | cut -f 2 | tr ' ' '\n' | sed '/^ *$/d' | sort | uniq >  tmp1.txt
COUNTER=1
while read p; do
echo "$p\t$COUNTER";
COUNTER=$((COUNTER + 1));
done < tmp1.txt > lex_IOB.txt
echo "<unk>\t$COUNTER" >> lex_IOB.txt
echo "<espilon>\t0" | cat - lex_IOB.txt > temp && mv temp lex_IOB.txt

rm tmp.txt
rm tmp1.txt
