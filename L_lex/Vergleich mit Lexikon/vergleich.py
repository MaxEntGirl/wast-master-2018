new_words = open("new_words.txt", "r")
words_de = open("brief_de_dela.txt", "r")
words_en = open("brief_en_dela.txt", "r")
final_words = open("finale_Wortliste.txt", "w")

aktuelle_words = []
de_words = []
en_words = []
seq=''

#bilde Wortliste aus new_words
words = new_words.readlines()
for line in words:
    line = line.replace("\n", "")
    aktuelle_words.append(line)

dew = words_de.readlines()
for line in dew:
    w = line.split(',')
    w = w[0]
    if '\\' in w:
        w=w.split('\\')
        w=seq.join(w)
    #w = w.lower()
    de_words.append(w)

enw = words_en.readlines()
for line in enw:
    w = line.split(',')
    w = w[0]
    if '\\' in w:
        w=w.split('\\')
        w=seq.join(w)
    #w = w.lower()
    en_words.append(w)

for w in aktuelle_words:
    if w not in en_words:
        if w not in de_words:
            final_words.write(w + "\n")


new_words.close()
words_de.close()
words_en.close()
final_words.close()
