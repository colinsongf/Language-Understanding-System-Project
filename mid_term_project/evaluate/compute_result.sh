#!/bin/bash
## Project: LUS Spring project
## @author Federico Marinelli - federico.marinelli@studenti.unitn.it

## -- COMPUTING THE COMPOSITION (W o W2C o C) AND GENERATE THE FILE FOR THE EVALUATION --
##
## Input: [1] - Path test set


#input variables, with default values
test_set=${1:-../data/NLSPARQL.test.data}

#setting up the test-set
cat $test_set | 
cut -f 1 |
sed 's/^ *$/#/g' | #replace empty line with some special symbol (#)
tr '\n' ' ' | 
tr '#' '\n' |
sed 's/^ *//g;s/ *$//g' > tmp  #clean redundant spaces; result on tmp

line_to_write=1

while read p; 
do
    #reading a word on the test-set (tmp file)
    #make word's fst
    #compose the word fst with the w2c fst (already componed with the concepts)
    #applying fstshortestpath, fstrmepsilon, fsttopsort
    #print output on tmp2
	echo $p | farcompilestrings --symbols=../word_to_concept/lexicon.txt --unknown_symbol="<unk>" --generate_keys=1 --keep_symbols | farextract --filename_suffix='.fst'
	fstcompose 1.fst ../word_to_concept/word2con.fst | fstcompose - ../language_model/con.lm | fstshortestpath | fstrmepsilon | fsttopsort > tmp2
	fstprint --isymbols=../word_to_concept/lexicon.txt --osymbols=../word_to_concept/lexicon.txt < tmp2

    #setting up the file for the evaluation
done < tmp

#cleaning up
rm 1.fst
rm tmp2
rm tmp



