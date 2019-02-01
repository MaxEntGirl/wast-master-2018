#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Dieses Skript durchsucht ein Verzeichnis und extrahiert alle Titel und Texte aus allen Dateien 
# innerhalb des Verzeichnisses, den Ort des Verzeichnisses fraegt das Verzeichnis ab.
# Der Ort sollte in dieser Art angegeben werden: Desktop/Seminar/wast-master-2018/E_Brief/FIBA2CIS/output/text
# Die Ergebnisse werden in eine einzige Datei geschrieben, um alle Informationen an einem Ort zu sammeln



from os import walk
import re
import codecs
from langdetect import detect
import string
import codecs

sammelfile = codecs.open("sammel.txt", "w",encoding='utf8')
name = []
current_letter = ""
wordlist = {}
#print(detect("Hallo"))
#print(detect("Hören"))
print(string.punctuation)
dir = raw_input('Enter Location of letters: ')

# Um das Verzeichnis zu durchsuchen, uebergibt man der Walk-Funktion einfach den Ort des Verzeichnisses, das man durchsuchen moechte
#for path, drive, name in walk('/home/v/vordermaier/Desktop/Seminar/wast-master-2018/E_Brief/FIBA2CIS/output/text'):
    #print(name)
for path, drive, name in walk(dir):
    print("Searching Directory...")

# Extraktion der Titel und Texte
# Das Resultat wird in die Datei Wortliste\sammel.txt geschrieben
for i in name:
    #print(i)
	#Uebergebe den Ort des Verzeichnisses(den selben wie vorher) + der aktuelle Dateiname i, um die Dateien zu oeffnen
    file = codecs.open(dir + "/" + i, 'r')
    text = file.read().decode('utf-8')
    text = text.replace("\n", " ")

	# Extraktion der Titel
    result = re.search('Title:(.*)sourceDesc:', text)
    current_letter = result.group(1)
    

	#Extraktion der Texte
    result = re.search('Text:(.*)',text)
    current_letter = current_letter + result.group(1)
    
    
    
    #version2
    #print(current_letter)
    #try:
    lang = detect(current_letter)
    #print(lang)
    #transl = string.maketrans(string.punctuation, ' '*len(string.punctuation))
    for i in string.punctuation:
        current_letter = current_letter.replace(i, " ")
    print(current_letter)
    #current_letter = current_letter.translate(transl)
    words = current_letter.split()
    print(words)
        
    for word in words:
        #Wörter, die komplett großgeschrieben werden, werden verändert, sodas nur der erste Buchstabe groß bleibt
        if(word.isupper()):
            word = word.capitalize()
        if word not in wordlist:
            wordlist[word] = lang
        
    #except:
     #   print("ERROR")
    
    
    
    

    file.close()

wordkeys = wordlist.keys()
wordkeys.sort()
for i in wordkeys:
    sammelfile.write(i + " " + wordlist[i])
    sammelfile.write("\n")
#print(wordlist)

sammelfile.close()
