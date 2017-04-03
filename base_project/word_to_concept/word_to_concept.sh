#!/bin/bash
## Project: LUS Spring project
## @author Federico Marinelli - federico.marinelli@studenti.unitn.it

## -- CREATE FST WORD2CONCEPT --
## Input: [1] - file of the training data
##        [2] - threshold value to apply in order to apply cut-off smoothing

#input variables, with default values
TRESHOLD=${1:-"1"}
TRAIN_SET=${2:-../data/NLSPARQL.train.data}

cd "${0%/*}"

echo "[] --> Computing word2concept fst.."
echo "[TRAINSET PATH] = $TRAIN_SET"
echo "[THRESHOLD CUT-OFF SMOOTHING] = $TRESHOLD"

#Counting the number of concepts
cat $TRAIN_SET | cut -f 2 |
sed '/^ *$/d' |     #remove empty lines
sort | uniq -c | 	#unique list with counts
sed 's/^ *//g' | 	#remove leading space
awk '{OFS="\t"; print $2,$1}' > CON.counts #swap columns & use tab for separator

#Counting the number of words + concepts
cat $TRAIN_SET  |
sed '/^ *$/d' |     #remove empty lines
sort | uniq -c |	#unique list with counts
sed 's/^ *//g' | 	#remove leading space
awk '{OFS="\t"; print $2,$3,$1}' > TOK_CON.counts #swap columns & use tab for separator

#Calculating the probabilities P(wi|ci) using the previous file
#I'm using a cut-off smoothing with threshold
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
while read p; 
do 
	echo "0\t0\t$p"; 
done < TOK_CON.probs > TOK_CON.machine

while read con count 
do
    n_concepts=$(wc -l < CON.counts)
    if [ "$TRESHOLD" == "0" ]; then
        cost=$(echo "-l(1 / $n_concepts)" | bc -l)
    else
        UNK=$((UNK / $n_concepts))
        cost=$(echo "-l($UNK / $count)" | bc -l)
    fi
	echo "0\t0\t<unk>\t$con\t$cost"
done < CON.counts >> TOK_CON.machine
echo "0" >> TOK_CON.machine

#generating the lexicon
sh generate_lex.sh

#compiling the fst
fstcompile --isymbols=lexicon.txt --osymbols=lexicon.txt TOK_CON.machine > word2con.fst

#drawing the fst
fstdraw --isymbols=lexicon.txt --osymbols=lexicon.txt word2con.fst | dot -Teps > word2con.eps

#cleaning up
rm  CON.counts
rm  TOK_CON.counts
rm  TOK_CON.probs
rm  TOK_CON.machine

