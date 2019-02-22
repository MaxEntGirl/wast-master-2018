#Dieses Script vergleicht die erstellte Wortliste mit dem aktuellen Lexikon
#Alle Wörter die nicht in dem Lexikon zu finden waren werden in der Datei new_words.txt gespeichert

new_words = open("new_words.txt", 'w',encoding='UTF-8')
existing_words=[] #Wortliste des Lexikons
seq=''
#öffne das aktuelle Lexikon
with open("witt_WAB_dela_XIX.txt", "r",encoding='UTF-8')as f:
	lexikon=f.readlines()
	for line in lexikon:
		w = line.split(',')
		w = w[0]
		if '\\' in w:
			w=w.split('\\')
			w=seq.join(w)
		w = w.lower()
		existing_words.append(w)

#öffne die erstellte Wortliste mit potenziell neuen Wörtern
with open("word_candidates.txt", "r",encoding='UTF-8') as l:
	words=l.readlines()
	i = 0
	for w in words:
		w = w.replace("\n", "")
		w = w.lower()
		if w not in existing_words:
			i += 1
			new_words.write(w + "\n") #Neue Wörter werden in die Datei new_words.txt geschrieben

print(i,'words are new to the lexicon.')

new_words.close()
f.close()
l.close()



