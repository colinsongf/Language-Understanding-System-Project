#!/bin/bash

# Student: Federico Marinelli 187418

cat NLSPARQL.train.feats.txt |\ 	#getting the data from the train file
cut -f 1 -f 3 |\	#we need only the first and the third columns
sed '/^ *$/d' |\	#remove empty lines
sort | uniq |\ 		# unique list of word to lexeme
sed 's/^ *//g' > lexeme.txt		#removing leading space and print the output on file

while read p; 
	do echo -e "0\t0\t$p\t0"; 
done < lexeme.txt > lemmatization.fst #creating the file for the transducer "lemmatization.fst"
