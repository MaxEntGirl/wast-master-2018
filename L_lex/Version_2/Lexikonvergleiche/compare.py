#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Dieses Script vergleicht die erstellte Wortliste mit dem aktuellen Lexikon
# Alle Wörter die nicht in dem Lexikon zu finden waren werden in der Datei new_words.txt gespeichert
# Problematische Wörter, wie Wörter die nicht englisch oder deutsch sind, werden erst einmal in problem_words.txt gespeichert
# Wörter die im Lexikon sind, aber die Groß-/Kleinschreibung unterschiedlich ist, werden in unnessecary_words.txt gespeichert

import codecs

new_words_de = codecs.open("new_words_de.txt", 'w',encoding='UTF-8')
new_words_en = codecs.open("new_words_en.txt", 'w',encoding='UTF-8')
prob_words = codecs.open("problem_words.txt", 'w',encoding='UTF-8')
unness_words = codecs.open("unnessecary_words.txt", 'w',encoding='UTF-8')
existing_words=[] # Wortliste des Witt-Lexikons
de_words = []	# Wortliste aus dem deutschen Lexikon
en_words = []   # Wortliste aus dem englischen Lexikon
seq=''
new_candidates = [] # zwischenstand der Kandidaten
final_candidates_de = [] # Finaler Stand der deutschen Kandidaten
final_candidates_en = [] # Finaler Stand der englischen Kandidaten
problem_words = []	# Wörter die problematisch sind
unnessecary_words = [] # Wörter die auf andere Art schon im Lexikon sind


#öffnet das aktuelle Lexikon
with codecs.open("witt_WAB_dela_XIX.txt", "r",encoding='UTF-8')as f:
    lexikon=f.readlines()
    for line in lexikon:
        w = line.split(',')
        w = w[0]
        if '\\' in w:
            w=w.split('\\')
            w=seq.join(w)
        existing_words.append(w)

#öffnet brief_de_dela.txt (deutsches Lexikon)
with codecs.open("brief_de_dela.txt", "r",encoding='UTF-8')as words_de:
    dew = words_de.readlines()
    for line in dew:
        w = line.split(',')
        w = w[0]
        if '\\' in w:
            w=w.split('\\')
            w=seq.join(w)
        de_words.append(w)
        
#öffnet brief_en_dela.txt(englisches Lexikon)
with codecs.open("brief_en_dela.txt", "r",encoding='UTF-8')as words_en:
    dew = words_en.readlines()
    for line in dew:
        w = line.split(',')
        w = w[0]
        if '\\' in w:
            w=w.split('\\')
            w=seq.join(w)
        en_words.append(w)

#öffne die erstellte Wortliste mit potenziell neuen Wörtern
with codecs.open("sammel.txt", "r",encoding='UTF-8') as l:
    words=l.readlines()
    i = 0
    for w in words:
        w = w.replace("\n", "")
        tupel = w.split()
        
        #Alle Sprachen außer de en aussortieren
        if(tupel[1] != "de" and tupel[1] != "en"):
            problem_words.append(tupel)
        #Vergleiche mit Lexika
        else:
            if(tupel[0] not in existing_words):
                if(tupel[1] == "de" and tupel[0] not in de_words):
                    new_candidates.append(tupel)
                if(tupel[1] == "en" and tupel[0] not in en_words):
                    new_candidates.append(tupel)
    
    # Kopien der Lexika für Kontrolle auf Groß-/Kleinschreibung
    de_words_new = []
    for i in de_words:
        new = i.lower()
        de_words_new.append(new)
    en_words_new = []
    for i in en_words:
        new = i.lower()
        en_words_new.append(new)
    existing_words_new = []
    for i in existing_words:
        new = i.lower()
        existing_words_new.append(new)
    
	# Kontrolle 
    for w in new_candidates:
        if(w[1] == "de"):
            if(w[0].lower() not in de_words_new and w[0].lower() not in existing_words_new):
                #if (w[0] not in de_words_new and w[0] not in existing_words_new):
                final_candidates_de.append(w)
                #else:
                 #    unnessecary_words.append(w)
            else:
                unnessecary_words.append(w)
                print(w[0])


        elif(w[1] == "en"):
            if w[0].lower() not in en_words_new and w[0].lower() not in existing_words_new:
                #if w[0] not in en_words and w[0] not in existing_words:
                final_candidates_en.append(w)
                #else:
                #    unnessecary_words.append(w)
            else:
                unnessecary_words.append(w)

# Erstellen des Outputs
for entry in final_candidates_de:
    new_words_de.write(entry[0])
    new_words_de.write("\n")
for entry in final_candidates_en:
    new_words_en.write(entry[0])
    new_words_en.write("\n")
for entry in problem_words:
    prob_words.write(entry[0] + " " + entry[1])
    prob_words.write("\n")
for entry in unnessecary_words:
    unness_words.write(entry[0] + " " + entry[1])
    unness_words.write("\n")

print(str(len(final_candidates_de)) + " new german words!")
print(str(len(final_candidates_en)) + " new english words!")
print(str(len(problem_words)) + " problem_words!")
print(str(len(unnessecary_words)) + " unnessecary_words words!")

new_words_de.close()
new_words_en.close()
words_de.close()
words_en.close()
f.close()
l.close()
prob_words.close()
unness_words.close()