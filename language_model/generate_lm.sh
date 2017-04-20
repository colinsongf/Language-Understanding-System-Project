#!/bin/bash
## Project: LUS Spring project
## @author Federico Marinelli - federico.marinelli@studenti.unitn.it

## -- GENERATE THE LANGUAGE MODEL --
## Input: [1] - order size
##        [2] - method
##        [3] - train_set PATH
##        [2] - lexicon PATH


#initizializing variables (if no iput they have defaults values)
order=${1:-"4"}
method=${2:-"kneser_ney"}
data=${3:-../data/NLSPARQL.train.data}
lex=${4:-../word_to_concept/lexicon.txt}

#moving into the correct dir
cd "${0%/*}"

#console log
echo "[] --> Computing LM.."
echo "[ ORDER ] = $order"
echo "[ METHOD ] = $method"

#setting up the dataset
cat $data |
cut -f 2 | 
sed 's/^ *$/#/g' | 
tr '\n' ' ' | 
tr '#' '\n' | 
sed 's/^ *//g;s/ *$//g' > data.txt

#compuling the language model
farcompilestrings --symbols=$lex --unknown_symbol='<unk>' data.txt > data.far
ngramcount --order=$order --require_symbols=false data.far > con.cnt
ngrammake --method=$method con.cnt > con.lm

#cleaning up
rm data.far
rm con.cnt
rm data.txt
