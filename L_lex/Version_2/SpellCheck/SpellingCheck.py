#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#Author: Di Wu
#Date:   24.2.2019

# This programm check the spelling of the words in the selected word list and save the corrected word pairs in file 'words_to_be_corrected'.
# Here the pyspellchecker is used: it supports multiple languages including English, Spanish, German, French, and Portuguese, dictionaries were generated using the WordFrequency project on GitHub.
# In total 1597 words, 869 german words and 728 english are roughly picked out as words to-be corrected

from spellchecker import SpellChecker

de_file = open('C:/Users/Ida/PycharmProjects/wast-master-2018/L_lex/Version_2/Lexikonvergleiche/new_words_de.txt', 'r', encoding='UTF-8')
en_file = open('C:/Users/Ida/PycharmProjects/wast-master-2018/L_lex/Version_2/Lexikonvergleiche/new_words_en.txt', 'r', encoding='UTF-8')
correction=open('words_to_be_corrected.txt','w',encoding='UTF-8')
de_text = de_file.readlines()
en_text = en_file.readlines()
de_list=[]
en_list=[]
de_checker = SpellChecker(language='de')
en_checker = SpellChecker(language='en')
for dw in de_text:
    dw = dw.replace('\n','')
    corrected_word = de_checker.correction(dw)
    if dw is not corrected_word:
        pair = dw + '--' + corrected_word + '\n'
        correction.write(pair)
        de_list.append(corrected_word)

for ew in en_text:
    ew = ew.replace('\n', '')
    corrected_word = en_checker.correction(ew)
    if ew is not corrected_word:
        pair = ew + '--' + corrected_word + '\n'
        correction.write(pair)
        en_list.append(corrected_word)


de_file.close()
en_file.close()
correction.close()










'''
from langdetect import detect

file = open("Restliste.txt", 'r', encoding='UTF-8')
OtherLang=open('OtherLanguage.txt','w',encoding='UTF-8')
text = file.readlines()

langs={}
en={}
de={}
for w in text:
    w = w.replace("\n", "")
    lang = detect(w)
    try:
        OtherLang.write(w,' ',lang)
        if(lang not in langs):
            langs[lang] = 1
        else:
            langs[lang] += 1

        if lang == 'de':
            en[w]=lang
        elif lang == 'en':
            de[w]=lang
        else:
            langs[w]=lang
            OtherLang.write(w)
            OtherLang.write('\n')

    except ValueError:
        print(w,'can not be detceted.')




print('there are', len(en), 'english words','and',len(de),'german words')
print('and we have', len(langs), 'words from other languages than English and German.')

file.close()
OtherLang.close()'''
