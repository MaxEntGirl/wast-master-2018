#Dieses Script ist nur experimentel und dient dazu herauszufinden, ob ein neues Wort bereits als Lemma in dem aktuellen Lexikon existiert
#Alle gefundenen Lemmas werden in lemmas.txt gespeichert.
#Dies ist nicht nötig für den Hauptablauf und dient lediglich als zusätzliche Information

import re

new_words = open("new_words.txt", 'r',encoding='UTF-8')
lexikon = open("witt_WAB_dela_XIX.txt", "r",encoding='UTF-8')
new_lemmas = open("lemmas.txt", "w",encoding="UTF-8")
existing_lemmas=[]
seq=''

#Bilde Lemmaliste aus dem Lexikon
lemmas=lexikon.readlines()
for line in lemmas:
    w = line.split(',')
    w = w[1]
    if '\\' in w:
        w = w.split('\\')
        w = seq.join(w)

    w = re.search("(.*)\.", w)
    if w != None:
        if w.group(1) != '':
            existing_lemmas.append(w.group(1))

words = new_words.readlines()

#Vergleiche die Wortliste aus new_words.txt mit den Lemmas und schreibe Resultate in lemmas.txt
for w in words:
    w = w.replace("\n", "")
    if w in existing_lemmas:
        new_lemmas.write(w + "\n")

new_words.close()
lexikon.close()
new_lemmas.close()

