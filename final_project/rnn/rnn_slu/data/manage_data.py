import random
import collections

def generateValidation(dim):
	count = 0
	state = 0
	validation = []
	train = []
	for line in open("tmp/tmp_train.txt"):
		w = line.split("\t")
		if len(w) == 1:
			if count <= dim:
				count+=1
			else:
				state=1
		if state == 0:
			validation.append(line)
		else:
			train.append(line)
	return validation, train

def getSentences():
	sentence = []
	all_sent = []
	global train
	for line in open("train.data"):
		w = line.split("\t")
		if len(w) > 1:
			sentence.append(line)
		else:
			all_sent.append(sentence)
			sentence = []
	return all_sent


def generateDicts(train):
	d = dict()
	c = dict()
	count=0
	count2=0
	f_word = open("tmp/word_dict.data","w")
	f_label = open("tmp/label_dict.data","w")
	for line in train:
		w = line.split("\t")
		if len(w) > 1:
			if w[0] not in d:
				d[w[0]]=count
				f_word.write(w[0]+'\t'+str(count)+"\n")
				count+=1
			if w[1]not in c:
				c[w[1]]=count2
				f_label.write(w[1][:len(w[1])-1]+'\t'+str(count2)+"\n")
				count2+=1
	for line in open("test.data"):
		x = line.split("\t")
		if len(x) > 1:
			if x[1]not in c:
				c[x[1]]=count2
				f_label.write(x[1][:len(x[1])-1]+'\t'+str(count2)+"\n")
				count2+=1
	f_word.write("<UNK>"+'\t'+str(count))

def print_files(validation, train):
	f_train = open("tmp/train.data","w")
	f_validation = open("tmp/validation.data","w")
	for line in validation:
		f_validation.write(line)
	for line in train:
		f_train.write(line)
	generateDicts(train)


all_sent = getSentences()
random.shuffle(all_sent)

f = open("tmp/tmp_train.txt","w")
for sentence in all_sent:
	for line in sentence:
		f.write(line)
	f.write("\n")

validation, train = generateValidation(300)	
print_files(validation, train)


