#!/usr/bin/env python
# -*- coding: utf-8 -*-
# This programm resorted the entries from 'cleaned word list' according to following rules:
# 1. Simplifying the Genus of german words: 'Ausgrabungen,Ausgrabung.N:4pf:3pf:2pf:1pf' -> 'Ausgrabungen,Ausgrabung.N:f'
# 2. Simplifying the singular and plural of english words: 'ask,ask.V::g1s:g1p:g2s:g2p:g3p -> 'ask,ask.V''
# 3. Ranked alphabetically
# 4. Adding language tag ('de','en') after every word if any match found crosschecking words from'clean_wordlist'

import re

text= open('cleaned_words.txt', 'r', encoding='UTF-8')
sorted=open('new_cleaned_words.txt','w',encoding='UTF-8')
word_lang=open('C:/Users/Ida/PycharmProjects/wast-master-2018/L_lex/Version_2/Lexikonvergleiche/clean_wordlist.txt','r',encoding='UTF-8')
d={}
lines=[]
for l in word_lang.readlines():
    l=l.split(' ')
    d[l[0]]=l[1]

print(d.items())
words = text.readlines()
for w in words:
    word = w.split(',')[0]
    w = w.replace('\n','')
#    w = re.sub('V\#\d','V',w)
    w = re.sub('(?<=N)((:)(\d)(.)(.)){1,4}',r':\5',w)
    w = re.sub('(?<=V)::.+','', w)
    if word in d.keys():
         line = w + d[word]
    else:
         line = w + '\n'
    lines.append(line)

lines.sort()
for l in lines:
    print(l)
    sorted.write(l)

text.close()
sorted.close()
word_lang.close()
