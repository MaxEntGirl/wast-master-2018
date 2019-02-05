#!/usr/bin/env python
# -*- coding: utf-8 -*-

#Dieses Script vergleicht die erstellte Wortliste mit dem aktuellen Lexikon
#Alle Wörter die nicht in dem Lexikon zu finden waren werden in der Datei new_words.txt gespeichert

import codecs

new_words = codecs.open("new_words.txt", 'w',encoding='UTF-8')
prob_words = codecs.open("problem_words.txt", 'w',encoding='UTF-8')
unness_words = codecs.open("unnessecary_words.txt", 'w',encoding='UTF-8')
existing_words=[] #Wortliste des Lexikons
de_words = []
en_words = []
seq=''
new_candidates = []
final_candidates = []
problem_words = []
unnessecary_words = []


#öffne das aktuelle Lexikon
with codecs.open("witt_WAB_dela_XIX.txt", "r",encoding='UTF-8')as f:
    lexikon=f.readlines()
    for line in lexikon:
        w = line.split(',')
        w = w[0]
        if '\\' in w:
            w=w.split('\\')
            w=seq.join(w)
        #w = w.lower() 
        existing_words.append(w)

#öffnet brief_de_dela.txt
with codecs.open("brief_de_dela.txt", "r",encoding='UTF-8')as words_de:
    dew = words_de.readlines()
    for line in dew:
        w = line.split(',')
        w = w[0]
        if '\\' in w:
            w=w.split('\\')
            w=seq.join(w)
        #w = w.lower()
        de_words.append(w)
        
#öffnet brief_en_dela.txt
with codecs.open("brief_en_dela.txt", "r",encoding='UTF-8')as words_en:
    dew = words_en.readlines()
    for line in dew:
        w = line.split(',')
        w = w[0]
        if '\\' in w:
            w=w.split('\\')
            w=seq.join(w)
        #w = w.lower()
        en_words.append(w)

#öffne die erstellte Wortliste mit potenziell neuen Wörtern
with codecs.open("sammel.txt", "r",encoding='UTF-8') as l:
    words=l.readlines()
    i = 0
    for w in words:
        #print(w)
        
        w = w.replace("\n", "")
        tupel = w.split()
        #print(tupel)
        
        #Alle Sprachen außer de en aussortieren
        #print(tupel[1])
        #print(tupel[1] != "de")
        if(tupel[1] != "de" and tupel[1] != "en"):
            problem_words.append(tupel)
        #Vergleiche mit Lexika
        else:
            if(tupel[0] not in existing_words):
                if(tupel[1] == "de" and tupel[0] not in de_words):
                    new_candidates.append(tupel)
                if(tupel[1] == "en" and tupel[0] not in en_words):
                    new_candidates.append(tupel)
    
    
    de_words_new = []
    for i in de_words:
        new = i.lower()
        de_words_new.append(new)
    
    en_words_new = []
    for i in en_words:
        #print(i)
        new = i.lower()
        en_words_new.append(new)

    existing_words_new = []
    for i in existing_words:
        new = i.lower()
        existing_words_new.append(new)
    
    
    print(str(len(new_candidates)) + " candidates!")
    for w in new_candidates:
        if(w[0] == "Danach"):
            print("danach" in existing_words_new)


        if(w[1] == "de"):
            if(w[0].lower() not in de_words_new and w[0].lower() not in existing_words_new):
                if (w[0] not in de_words_new and w[0] not in existing_words_new):
                    final_candidates.append(w)
                else:
                    unnessecary_words.append(w)
            else:
                unnessecary_words.append(w)


        elif(w[1] == "en"):
            if w[0].lower() not in en_words_new and w[0].lower() not in existing_words_new:
                if w[0] not in en_words and w[0] not in existing_words:
                    final_candidates.append(w)
                else:
                    unnessecary_words.append(w)
            else:
                unnessecary_words.append(w)



#print(i,'words are new to the lexicon.')
for entry in final_candidates:
    new_words.write(entry[0] + " " + entry[1])
    new_words.write("\n")
for entry in problem_words:
    prob_words.write(entry[0] + " " + entry[1])
    prob_words.write("\n")
for entry in unnessecary_words:
    unness_words.write(entry[0] + " " + entry[1])
    unness_words.write("\n")

print(str(len(final_candidates)) + " new words!")
print(str(len(problem_words)) + " problem_words!")
print(str(len(unnessecary_words)) + " unnessecary_words words!")

#for i in unnessecary_words:
    #print(i)

new_words.close()
words_de.close()
words_en.close()
f.close()
l.close()
prob_words.close()
unness_words.close()