#!/usr/bin/env python
# -*- coding: utf-8 -*-

import codecs

#Variablen
save_words = {}


de_words = codecs.open("brief_de_dela.txt", "r",encoding='UTF-8')
en_words = codecs.open("brief_en_dela.txt", "r",encoding='UTF-8')
cleaned_words = codecs.open("cleaned_words.txt", "w",encoding='UTF-8')

de_lexikon=de_words.readlines()
for line in de_lexikon:
	cand = line.split(',')
	if cand[0] not in save_words:
		save_words[cand[0]] = line
	else:
		if len(line) < len(save_words[cand[0]]):
			save_words[cand[0]] = line
			
en_lexikon=en_words.readlines()
for line in en_lexikon:
	cand = line.split(',')
	if cand[0] not in save_words:
		save_words[cand[0]] = line
	else:
		if len(line) < len(save_words[cand[0]]):
			save_words[cand[0]] = line

for i in save_words.values():
	print(i)
	cleaned_words.write(i)
print(len(save_words))

de_words.close()
en_words.close()
cleaned_words.close()