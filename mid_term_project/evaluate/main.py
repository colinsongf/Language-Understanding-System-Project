#!/bin/bash
## Project: LUS Spring project
## @author Federico Marinelli - federico.marinelli@studenti.unitn.it

## Generating the file for the evaluation, named toEvaluate.txt. It will be passed to the conlleval.

import sys
from subprocess import Popen
import subprocess, math, os

#os.chdir('/Users/fcks/Desktop/LUS-Spring-Project-master/base_project/evaluate')

def get_output_print():
	print "[!] --> Computing compositions results"
	output = []
	proc=Popen('./compute_result.sh', stdout=subprocess.PIPE, shell=True)
	output.append(proc.stdout.read())
	return output

output = get_output_print()
predicted = []
for x in output:
	lines=x.split("\n")
	for line in lines:
		parts = line.split("\t")
		if(len(parts)>2):
			predicted.append(parts[3])
		else:
			predicted.append("")

index=0
f = open("toEvaluate.txt", "w")
for line in open("../data/NLSPARQL.test.data"):
	f.write(line[0:len(line)-1]+"\t"+predicted[index]+"\n")
	index+=1
f.close()

proc=Popen("cat toEvaluate.txt | cut -f 1,2 > col12.txt ", stdout=subprocess.PIPE, shell=True)
proc.communicate()

proc=Popen("cat toEvaluate.txt | cut -f 3 > col3.txt ", stdout=subprocess.PIPE, shell=True)
proc.communicate()


f = open("new_col3", "w")
for line in open("col3.txt", "r"):
	if(line[0:1] == '$'):
		f.write('O\n')
	else:
		f.write(line)

f.close()
proc=Popen("paste col12.txt new_col3 > toEvaluate.txt ", stdout=subprocess.PIPE, shell=True)
proc.communicate()
proc=Popen("./conlleval.pl -d '\t' < toEvaluate.txt > results", stdout=subprocess.PIPE, shell=True)
proc.communicate()

