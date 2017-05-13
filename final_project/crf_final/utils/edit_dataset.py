## Project: LUS final project
## @author Federico Marinelli - federico.marinelli@studenti.unitn.it

#
#	Utils file -> Used to add feature column into the dataset 
#

TRAINSET_PATH="../data/NLSPARQL.train.data";
TESTSET_PATH="../data/NLSPARQL.test.data"



def editOTags():
	for line in open("NLSPARQL.train.data"):
		p = line.split("\t")
		
		if len(p)>1:
			if (p[1][0:len(p[1])-1] == 'O'):
				p[1] = "$-" + p[0] + "\n"
			f.write(p[0]+"\t"+p[1])
		else:
			f.write("\n")

def printPrefix(dim, path):
	f = open("prefix_test"+str(dim), "w")
	for line in open(path):
		w = line.split("\t")
		if len(w)>1:
			f.write(str(w[0][0:dim])+"\n")
		else:
			f.write("\n")
	return

def printSuffix(dim, path):
	f = open("suffix_test"+str(dim), "w")
	for line in open(path):
		w = line.split("\t")
		if len(w)>1:
			f.write(str(w[0][-dim:])+"\n")
		else:
			f.write("\n")
	return

# MAIN 
printSuffix(3, TESTSET_PATH)
printSuffix(2, TESTSET_PATH)
printSuffix(1, TESTSET_PATH)

printPrefix(1, TESTSET_PATH)
printPrefix(2, TESTSET_PATH)
printPrefix(3, TESTSET_PATH)

