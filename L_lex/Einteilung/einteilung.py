unnötig = open("unnötige_wörter.txt", "w")
final = open("finale_Wortliste.txt", "r")
rest = open("rest.txt", "w")

lex_words=[]
seq=''

with open("witt_WAB_dela_XIX.txt", "r",encoding='UTF-8')as lex:
    lexikon=lex.readlines()
    for line in lexikon:
        w = line.split(',')
        w = w[0]
        if '\\' in w:
            w=w.split('\\')
            w=seq.join(w)
        #w = w.lower()
        lex_words.append(w)


final_words = []
words = final.readlines()
for line in words:
    line = line.replace("\n", "")
    if line.lower() in lex_words or line in lex_words:
        #final_words.append(line + "\n")
        unnötig.write(line + "\n")
    else:
        rest.write(line + "\n")


unnötig.close()
final.close()
lex.close()
rest.close()