#!/bin/bash
## Project: LUS Spring project
## @author Federico Marinelli - federico.marinelli@studenti.unitn.it

data=${1:-../data/NLSPARQL.train.data}
lex=${2:-../word_to_concept/lexicon.txt}

cat $data |
cut -f 2 | 
sed 's/^ *$/#/g' | 
tr '\n' ' ' | 
tr '#' '\n' | 
sed 's/^ *//g;s/ *$//g' > data.txt

farcompilestrings --symbols=$lex --unknown_symbol='<unk>' data.txt > data.far
ngramcount --order=3 --require_symbols=false data.far > con.cnt
ngrammake --method=witten_bell con.cnt > con.lm

rm data.far
rm con.cnt
rm data.txt
