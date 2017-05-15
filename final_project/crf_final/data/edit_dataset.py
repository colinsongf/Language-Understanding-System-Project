count = 0
train = []
validation = []
state = 0

def generateValidation():
	for line in open("train.txt"):
		w = line.split("\t")
		if len(w) == 1:
			if count != 300:
				count+=1
			else:
				state=1
		if state == 0:
			validation.append(line)
		else:
			train.append(line)

			
print validation



