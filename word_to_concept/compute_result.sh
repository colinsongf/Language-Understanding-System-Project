#!/bin/bash
## Project: LUS Spring project
## @author Federico Marinelli - federico.marinelli@studenti.unitn.it

## -- COMPUTING THE COMPOSITION (W o W2C o C) AND GENERATE THE FILE FOR THE EVALUATION --
##
## Input: [1] - Path test set
##        [2] - Path w2c fst
##        [3] - Path LM fst

#input variables, with default values
test_set=$(1:-../data/NLSPARQL.test.data}
w2c_fst=$(2:-tok2con.fst)
lm=$(3-:../language_model/con.lm)

#setting up the test-set
cat $test_set | 
cut -f 1 |
sed 's/^ *$/#/g' | #replace empty line with some special symbol (#)
tr '\n' ' ' | 
tr '#' '\n' |
sed 's/^ *//g;s/ *$//g' > tmp  #clean redundant spaces; result on tmp

line_to_write=1

#restoring the file toEvaluate.txt
if [ -f /toEvaluate.txt]; then
    rm -f toEvaluate.txt
fi

while read p; 
do
    #reading a word on the test-set (tmp file)
    #make word's fst
    #compose the word fst with the w2c fst (already componed with the c)
    #appling fstshortestpath, fstrmepsilon, fsttopsort
    #resulting print output on tmp2
	echo $p | farcompilestrings --symbols=lexicon.txt --unknown_symbol="<unk>" --generate_keys=1 --keep_symbols | farextract --filename_suffix='.fst'
	fstcompose 1.fst $w2c_fst | fstcompose - $lm | fstshortestpath | fstrmepsilon | fsttopsort |
	fstprint --isymbols=lexicon.txt --osymbols=lexicon.txt > tmp2

    #setting up the file for the evaluation
	while read line;
	do
        N=$(echo $line | wc -w) #counting the number of "colums" (if > 3 : not considered)
		if [ "$N" -gt "3" ]; then
            predicted=$(echo $line | awk '{print$4}')   #take the predicted value
            take_line=$(sed "${line_to_write}q;d" $test_set)   #take a line nth line on test_set file
            echo "$take_line\t$predicted" >> toEvaluate.txt  #printing the file for the evaluation
		else 
            echo "\n" >> toEvaluate.txt
		fi
		line_to_write=$((line_to_write + 1))
	done < tmp2
done < tmp

#cleaning up
rm -f 1.fst
rm -f tmp
rm -f tmp2

