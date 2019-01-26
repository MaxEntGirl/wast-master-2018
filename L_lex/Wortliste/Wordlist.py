#Dieses Script verwendet die gesammelten Texte in sammel.txt und extrahiert daraus eine Wortliste
#Die Wortliste wird in die Datei Wortliste\wordlist.txt geschrieben

import string

wordlist = open("wordlist.txt", "w")
textfile = open("sammel.txt", "r")
w_list = [] # Wortliste

text = textfile.readlines()

for line in text:
	#Lösche alle Punktuationszeichen
    transl = string.maketrans(string.punctuation, ' '*len(string.punctuation))
    line = line.translate(transl)

    words = line.split()

    for word in words:
	#Wörter, die komplett großgeschrieben werden, werden verändert, sodas nur der erste Buchstabe groß bleibt
	if(word.isupper()):
		word = word.capitalize()
	
    	if word not in w_list:
        	w_list.append(word)


#Wortliste wird alphabetisch sortiert
w_list.sort()

for word in w_list:
    wordlist.write(word)
    wordlist.write("\n")

wordlist.close()
textfile.close()
