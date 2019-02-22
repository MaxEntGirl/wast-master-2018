#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# This Script searches through a Directory and extracts all titles and texts out of the letters in that Directory
# The Location of the Directory is asked from the user
# The input should look something like this: /home/v/vordermaier/Desktop/Seminar/wast-master-2018/E_Brief/FIBA2CIS/output/text
# For every letter the script recognises the language
# The script produces a wordlist from all the letters
# Every Word has a tag that tells you the language of the letter it is from
# The result will be written in the file sammel.txt
 

#There are 447 words in the lanuage fr
#There are 7200 words in the lanuage en
#There are 281 words in the lanuage no
#There are 12164 words in the lanuage de
#There are 613 words in the lanuage da
#There are 41 words in the lanuage pl


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

for path, drive, name in walk(dir):
    print("Searching Directory...")

for i in name:
    file = codecs.open(dir + "/" + i, 'r')
    text = file.read().decode('utf-8')
    text = text.replace("\n", " ")

    result = re.search('Title:(.*)sourceDesc:', text)
    current_letter = result.group(1)
    
    result = re.search('Text:(.*)',text)
    current_letter = current_letter + result.group(1)
    
    lang = detect(current_letter)
    for i in string.punctuation:
		if i == "-":
			current_letter = current_letter.replace(i, "")
		else:
			current_letter = current_letter.replace(i, " ")
    words = current_letter.split()
    
    for word in words:
        if(word.isupper()):
            word = word.capitalize()
        if word not in wordlist:
            wordlist[word] = lang
        
    file.close()

wordkeys = wordlist.keys()
wordkeys.sort()

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
