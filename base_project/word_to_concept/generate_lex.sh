#!/bin/bash
## Project: LUS Spring project
## @author Federico Marinelli - federico.marinelli@studenti.unitn.it

## -- CREATE THE LEXICON (only for cut-off smoothing) --
## Input: TOK_CON.machine
##
## Description: I'm generating a lexicon from the TOK_CON.machine because
##              i'm using a cut-off smoothing with threshold, and I have to
##              user a proper dicitionary without the recurrences that I deleted
##              with the cut-off.


# taking the 3th and 4th columns, merge them in a single column
cd $(dirname $(realpath $0))

cat TOK_CON.machine | cut -f 3 > tmp.txt
cat TOK_CON.machine | cut -f 4 >> tmp.txt

# cleaning up the data
cat tmp.txt | tr ' ' '\n' | sed '/^ *$/d' | sort | uniq > tmp2.txt

# deleting the <UNK> (repetition)
awk '!/<unk>/' tmp2.txt > temp && mv temp tmp2.txt

# enumarate words
COUNTER=1
while read p; do
	echo "$p\t$COUNTER";
	COUNTER=$((COUNTER + 1));
done < tmp2.txt > lexicon.txt
echo "<unk>\t$COUNTER" >> lexicon.txt
echo "<epsilon>\t0" | cat - lexicon.txt > temp && mv temp lexicon.txt

# deleting temp files
rm tmp.txt
rm tmp2.txt
