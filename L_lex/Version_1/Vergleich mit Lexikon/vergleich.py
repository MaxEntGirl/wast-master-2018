#In diesem Script werden die Wörter aus new_words.txt mit den von Dr. Hadersbeck gestellten Wortlisten aus
#brief_de_dela.txt und brief_en_dela.txt verglichen
#Wenn Ein Wort in keinem der beiden Listen zu finden ist wird es in die Datei finale_Wortliste.txt gespeichert

new_words = open("new_words.txt", "r")
words_de = open("brief_de_dela.txt", "r") #Deutsche Wortliste
words_en = open("brief_en_dela.txt", "r") #Englische Wortliste
final_words = open("finale_Wortliste.txt", "w")

aktuelle_words = []
de_words = []
en_words = []
seq=''

#Bilde Wortliste aus new_words.txt
words = new_words.readlines()
for line in words:
    line = line.replace("\n", "")
    aktuelle_words.append(line)

#Bilde Wortliste aus brief_de_dela.txt	
dew = words_de.readlines()
for line in dew:
    w = line.split(',')
    w = w[0]
    if '\\' in w:
        w=w.split('\\')
        w=seq.join(w)
    #w = w.lower()
    de_words.append(w)

#Bilde Wortliste aus brief_en_dela.txt
enw = words_en.readlines()
for line in enw:
    w = line.split(',')
    w = w[0]
    if '\\' in w:
        w=w.split('\\')
        w=seq.join(w)
    #w = w.lower()
    en_words.append(w)

#Test ob die neuen Wörter in einer der beiden gestellten Wortlisten sind, wenn nicht, werden sie in final_words.txt gespeichert
for w in aktuelle_words:
    if w not in en_words:
        if w not in de_words:
            final_words.write(w + "\n")


new_words.close()
words_de.close()
words_en.close()
final_words.close()
