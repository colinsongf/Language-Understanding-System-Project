#!/bin/bash
## Project: LUS Spring project
## @author Federico Marinelli - federico.marinelli@studenti.unitn.it
order=${1:-"3"}
method=${2:-"witten_bell"}
data=${3:-../data/NLSPARQL.train.data}
lex=${4:-../word_to_concept/lexicon.txt}

cd "${0%/*}"

echo "[] --> Computing LM.."
echo "[ ORDER ] = $order"
echo "[ METHOD ] = $method"

cat $data |
cut -f 2 | 
sed 's/^ *$/#/g' | 
tr '\n' ' ' | 
tr '#' '\n' | 
sed 's/^ *//g;s/ *$//g' > data.txt

farcompilestrings --symbols=$lex --unknown_symbol='<unk>' data.txt > data.far
ngramcount --order=$order --require_symbols=false data.far > con.cnt
ngrammake --method=$method con.cnt > con.lm

rm data.far
rm con.cnt
rm data.txt
