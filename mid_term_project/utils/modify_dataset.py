import sys
#script used to modify the dataset in order to add evidence as prior probability
def change(file, out):
	f = open(file, "r")
	wr = open(out, "w")

	for line in f:
		
		if line == "prod\n":
			nL = f.readline()
			if nL == "by\n":
				wr.write("prod\n")
				wr.write("by.prod\n")
		elif line == "dir\n":
			nL = fi.readline()
			if nL == "by\n":
				wr.write("dir\n")
				wr.write("by.dir\n")
		else:
			wr.write(line)

	f.close()
	wr.close()

change("col2tmp.txt", "train_tmp.txt")



