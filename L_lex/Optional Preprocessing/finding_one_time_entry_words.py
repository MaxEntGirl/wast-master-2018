from nltk.stem import SnowballStemmer
stemmer=SnowballStemmer('german')

path=input('Please give the filepath which you want to use:')
new_words = open(path, 'r', encoding='UTF-8')
lexikonfile = open("witt_WAB_dela_XIX.txt", "r", encoding='UTF-8')
one_time_entry= open("one_time_entry.txt", 'w',encoding='UTF-8')
brand_new_entry= open("brand_new_entry.txt", 'w',encoding='UTF-8')

seq = ''
lexicons = []

l=lexikonfile.readlines()
for line in l:
    w = line.split(',')
    w = w[0]
    if '\\' in w:
        w = w.split('\\')
        w = seq.join(w)
    lexicons.append(w)

words = []

for w in new_words.readlines():
    w = w.replace("\n", "")
    if len(w.split(' ')) > 1:
        w = w.split(' ')[0]
    words.append(w)

def stemming(wordlist):

    lemmadict={}
    for word in wordlist:
        lemma=stemmer.stem(word)
        if word not in lemmadict.keys():
            lemmadict[word]=lemma
    return lemmadict


existing_lemmas=stemming(lexicons)
lemma_to_be=stemming(words)

entry={}
existing_entry={}
for w,l in lemma_to_be.items():
#    lm = w + ':' + l+'\n'
    if l in existing_lemmas.values():
        existing_entry[w]=l
        one_time_entry.write(w)
        one_time_entry.write('\n')
    else:
        entry[w]=l
        brand_new_entry.write(w)
        brand_new_entry.write('\n')

print('There are',len(words), 'new words,', len(existing_entry.keys()), 'words need one time entry,', len(entry.keys()),'words are totally new.')



new_words.close()
lexikonfile.close()
one_time_entry.close()
brand_new_entry.close()