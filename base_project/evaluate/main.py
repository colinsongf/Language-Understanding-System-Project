#!/bin/bash
## Project: LUS Spring project
## @author Federico Marinelli - federico.marinelli@studenti.unitn.it

import sys
from subprocess import Popen
import subprocess, math, os

os.chdir('/Users/fcks/Desktop/UNITN/Language-U-S/LUS-Spring-Project/base_project/evaluate')

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
proc=Popen("./conlleval.pl -d '\t' < toEvaluate.txt > results", stdout=subprocess.PIPE, shell=True)
proc.communicate()

