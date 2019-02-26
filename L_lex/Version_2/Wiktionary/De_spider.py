#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#Author: Di WU
#Date:   24.2.2019

# This is a spider using Beautifulsoup to collect german words' part of speech information(noun,verb,...) from Wiktionary pages.
# 653 out of 2381 german words find its results on wiktionary.
# The function to extract Genus and the english-wiktionary spider need further extension.

from urllib import request
from bs4 import BeautifulSoup as sp
from urllib.parse import quote


words=open("new_words_de.txt", 'r',encoding='UTF-8')
results=open("de_wordtype.txt", 'w',encoding='UTF-8')
lines = words.readlines()
de_keywords=[]
de_dict={}
word_wordtype={}
baseurl = "https://de.wiktionary.org/wiki/"

for w in lines:
    word = w.replace('\n','')
    keyword = quote(word)
    try:
        url = baseurl + keyword
        reponse = request.urlopen(url)
        print("Page found!", keyword)
        page = reponse.read().decode('utf-8')
        html = sp(page, 'html.parser')
        tag=html.find_all(href="/wiki/Hilfe:Wortart")
        type=tag[0].string
        word_wordtype[word]=type
        line=word+'---'+type+'\n'
        print(line)
        results.write(line)
    except:
        print('No results',keyword)
        line=word+'\n'
        results.write(line)



words.close()
results.close()
