new_words = open("new_words.txt", 'w',encoding='UTF-8')
existing_words=[]
seq=''
with open("witt_WAB_dela_XIX.txt", "r",encoding='UTF-8')as f:
    lexikon=f.readlines()
    for line in lexikon:
        w = line.split(',')
        w = w[0]
        if '\\' in w:
            w=w.split('\\')
            w=seq.join(w)

        existing_words.append(w)

with open("nice_word_list.txt", "r",encoding='UTF-8') as l:
    words=l.readlines()
    i = 0
    for w in words:
        if w not in existing_words:
           i += 1
           new_words.write(w)
'something fail in this loop:it writes almost all the words from nice_word list in'

print(i,'words are new to the lexicon.')

new_words.close()
f.close()
l.close()



