#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Dieses Skript durchsucht ein Verzeichnis und extrahiert alle Titel und Texte aus allen Dateien innerhalb des Verzeichnisses,
# den Ort des Verzeichnisses fraegt das Program ab.
# Der Ort sollte in dieser Art angegeben werden: Desktop/Seminar/wast-master-2018/E_Brief/FIBA2CIS/output/text
# Für jeden Brief wird außerdem die Sprache erkannt
# Aus den eingelesenen Briefen wird dann eine Wortliste erstellt
# Jedes Wort hat ein Sprachtag um die Erstellung der Lexikoneinträge zu Vereinfachung
# Das Resultat wird in die Datei sammel.txt geschrieben
#/home/v/vordermaier/Desktop/Seminar/wast-master-2018/E_Brief/FIBA2CIS/output/text/  

#There are 448 words in the lanuage fr (french)
#There are 7134 words in the lanuage en (english)
#There are 374 words in the lanuage no (norwegian)
#There are 12122 words in the lanuage de (german)
#There are 512 words in the lanuage da (danish)
#There are 41 words in the lanuage pl (polish)

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
languages = {}
dir = raw_input('Enter Location of letters: ')

# Um das Verzeichnis zu durchsuchen, uebergibt man der Walk-Funktion einfach den Ort des Verzeichnisses, das man durchsuchen moechte
for path, drive, name in walk(dir):
    print("Searching Directory...")

# Extraktion der Titel und Texte
for i in name:
	# Uebergebe den Ort des Verzeichnisses(den selben wie vorher) + der aktuelle Dateiname i, um die Dateien zu oeffnen
    file = codecs.open(dir + "/" + i, 'r')
    text = file.read().decode('utf-8')
    text = text.replace("\n", " ")

	# Extraktion der Titel
    result = re.search('Title:(.*)sourceDesc:', text)
    current_letter = result.group(1)
    

	# Extraktion der Texte
    result = re.search('Text:(.*)',text)
    current_letter = current_letter + result.group(1)
    
    # Spracherkennung
    lang = detect(current_letter)
    for i in string.punctuation:
		if i == "-":
			current_letter = current_letter.replace(i, "")
		else:
			current_letter = current_letter.replace(i, " ")
    words = current_letter.split()
    
	# Erweiterung der Wortliste 
    for word in words:
        #Wörter, die komplett großgeschrieben werden, werden verändert, sodas nur der erste Buchstabe groß bleibt
        if(word.isupper()):
            word = word.capitalize()
        if word not in wordlist:
            wordlist[word] = lang
        
    file.close()

wordkeys = wordlist.keys()
wordkeys.sort()

# Zählen der Vorkommen der Sprachen
for i in wordkeys:
    if wordlist[i] not in languages:
        languages[wordlist[i]] = 1
    else:
        languages[wordlist[i]] += 1
    
    sammelfile.write(i + " " + wordlist[i])
    sammelfile.write("\n")

for l in languages:
    print("There are " + str(languages[l]) + " words in the lanuage " + l)

sammelfile.close()
