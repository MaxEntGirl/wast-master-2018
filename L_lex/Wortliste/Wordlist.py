import string

wordlist = open("wordlist.txt", "w")
textfile = open("sammel.txt", "r")
w_list = []

text = textfile.readlines()

for line in text:
    #print(line)
    #tr = str.maketrans("", "", string.punctuation)
    #line = line.translate(string.maketrans("",""), string.punctuation)
    transl = string.maketrans(string.punctuation, ' '*len(string.punctuation))
    line = line.translate(transl)
    #line = line.translate(tr)
    #print(line)

    words = line.split()

    for word in words:
	#change words, that are all uppercase
	if(word.isupper()):
		print(word)
		word = word.capitalize()
	
    	if word not in w_list:
        	w_list.append(word)



w_list.sort()

for word in w_list:
    wordlist.write(word)
    wordlist.write("\n")

wordlist.close()
textfile.close()
