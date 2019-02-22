#Dieses Script liest eine Wortliste aus Komplette_Wortliste.txt und das aktuelle Lexikon eine
#Die Wortliste wird mit dem Lexikon verglichen
#Wenn ein Wort bereits im Lexikon steht (Die Groß und Kleinschreibung wird nicht beachtet!), wird das Wort in die Datei unnötige_wörter.txt geschrieben
#Der Rest in Restliste.txt

unnötig = open("unnötige_wörter.txt", "w")
final = open("Komplette_Wortliste.txt", "r")
rest = open("Restliste.txt", "w")

lex_words=[]
seq=''

#open Lexikon
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

#open Komplette_Wortliste.txt und vergleiche mit Lexikon
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