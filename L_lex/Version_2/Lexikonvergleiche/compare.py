#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# This script compares the wordlist from sammel.txt with the current Witt-Lex and the extracts of the CIS-Lex provided by Dr. Hadersbeck
# All words that were found in no of the Lexica, are saved to new_words_de.txt and new_words_en.txt
# Words that neither german nor english are beeing saved in problem_words.txt
# Words that are inside the Lexica, but their spelling in Upper/Lowercase differs, will be saved in unnessecary_words.txt

import codecs

new_words_de = codecs.open("new_words_de.txt", 'w',encoding='UTF-8')
new_words_en = codecs.open("new_words_en.txt", 'w',encoding='UTF-8')
prob_words = codecs.open("problem_words.txt", 'w',encoding='UTF-8')
unness_words = codecs.open("unnessecary_words.txt", 'w',encoding='UTF-8')
existing_words=[] # wordlist of Witt-Lex
de_words = []	# wordlist of the german Cis-Lex
en_words = []   # wordlist of the english Cis-Lex
seq=''
new_candidates = [] 
final_candidates_de = [] 
final_candidates_en = [] 
problem_words = []	
unnessecary_words = [] 


with codecs.open("witt_WAB_dela_XIX.txt", "r",encoding='UTF-8')as f:
    lexikon=f.readlines()
    for line in lexikon:
        w = line.split(',')
        w = w[0]
        if '\\' in w:
            w=w.split('\\')
            w=seq.join(w)
        existing_words.append(w)

with codecs.open("brief_de_dela.txt", "r",encoding='UTF-8')as words_de:
    dew = words_de.readlines()
    for line in dew:
        w = line.split(',')
        w = w[0]
        if '\\' in w:
            w=w.split('\\')
            w=seq.join(w)
        de_words.append(w)
        
with codecs.open("brief_en_dela.txt", "r",encoding='UTF-8')as words_en:
    dew = words_en.readlines()
    for line in dew:
        w = line.split(',')
        w = w[0]
        if '\\' in w:
            w=w.split('\\')
            w=seq.join(w)
        en_words.append(w)

with codecs.open("sammel.txt", "r",encoding='UTF-8') as l:
    words=l.readlines()
    i = 0
    for w in words:
        w = w.replace("\n", "")
        tupel = w.split()
        
        if(tupel[1] != "de" and tupel[1] != "en"):
            problem_words.append(tupel)
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
        new = i.lower()
        en_words_new.append(new)
    existing_words_new = []
    for i in existing_words:
        new = i.lower()
        existing_words_new.append(new)
    
    for w in new_candidates:
        if(w[1] == "de"):
            if(w[0].lower() not in de_words_new and w[0].lower() not in existing_words_new):
                final_candidates_de.append(w)
            else:
                unnessecary_words.append(w)
                print(w[0])

        elif(w[1] == "en"):
            if w[0].lower() not in en_words_new and w[0].lower() not in existing_words_new:
                final_candidates_en.append(w)
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
