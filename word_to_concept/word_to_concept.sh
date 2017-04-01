#!/bin/bash
## Project: LUS Spring project
## @author Federico Marinelli - federico.marinelli@studenti.unitn.it

## -- CREATE FST WORD2CONCEPT --
## Input: [1] - file of the training data
##        [2] - threshold value to apply in order to apply cut-off smoothing
##        [3] - the language model file

#input variables, with default values
TRAIN_SET=${1:-../data/NLSPARQL.train.data}
TRESHOLD=${2:-"1"}
LM=${3:-../language_model/con.lm}

echo "[TRAINSET PATH] = $TRAIN_SET"
echo "[THRESHOLD CUT-OFF SMOOTHING] = $TRESHOLD"
echo "[LM PATH] = $LM"

#Counting the number of concepts
echo "[] --> Counting the number of concepts..."
cat $TRAIN_SET | cut -f 2 |
sed '/^ *$/d' |     #remove empty lines
sort | uniq -c | 	#unique list with counts
sed 's/^ *//g' | 	#remove leading space
awk '{OFS="\t"; print $2,$1}' > CON.counts #swap columns & use tab for separator

#Counting the number of words + concepts
echo "[] --> Counting the number of concept+word..."
cat $TRAIN_SET  |
sed '/^ *$/d' |     #remove empty lines
sort | uniq -c |	#unique list with counts
sed 's/^ *//g' | 	#remove leading space
awk '{OFS="\t"; print $2,$3,$1}' > TOK_CON.counts #swap columns & use tab for separator


#Calculating the probabilities P(wi|ci) using the previous file
#I'm using a cut-off smoothing with threshold
echo "[] --> Computing probabilities..."
UNK=0
while read token con count 
do 
	if [ "$count" -gt "$TRESHOLD" ]; then   #threshold check
		con_count=$(grep "^$con\t" CON.counts | cut -f 2)
		cost=$(echo "-l($count / $con_count)" | bc -l)
		echo "$token\t$con\t$cost"
	else
		UNK=$((UNK + $count))
	fi
done < TOK_CON.counts > TOK_CON.probs

#printing the file for compiling the transducer
UNK=$((UNK / $(wc -l < CON.counts)))
while read p; 
do 
	echo "0\t0\t$p"; 
done < TOK_CON.probs > TOK_CON.machine

while read con count 
do
	cost=$(echo "-l($UNK / $count)" | bc -l)
	echo "0\t0\t<unk>\t$con\t$cost"
done < CON.counts >> TOK_CON.machine
echo "0" >> TOK_CON.machine

#cleaning up
rm -f CON.counts
rm -f TOK_CON.counts
rm -f TOK_CON.probs

#generating the lexicon
echo "[] --> Generating new lexicon..."
sh generate_lex.sh


#compiling the fst
echo "[] --> Compiling fst..."
fstcompile --isymbols=lexicon.txt --osymbols=lexicon.txt TOK_CON.machine > tok2con.fst

#drawing the fst
fstdraw --isymbols=lexicon.txt --osymbols=lexicon.txt tok2con.fst | dot -Teps > tok2con.eps

#componing the fst with the Language Model previusly created
fstcompose tok2con.fst $LM > com_w2c_lm.fst
echo "[DONE] --> fst generated as com_w2c_lm.fst"




