from difflib import SequenceMatcher

file = open("nice_word_list.txt", "r")
outfile = open("simil.txt", "w")

#print(SequenceMatcher(None, 'Abend', 'Abendessen').ratio())

#Variables
text = file.readlines()
list = []
new_word = ""
last_word = ""
small = ""
big = ""
simpoints = 0

#iterating through the given wordlist and only accepting words that are different than the others
#When more than 4 points are accumulated, than a word is dissimilar
for i in text:
    i = i.replace("\n", "")

    if len(list) == 0:
        list.append(i)
    else:
        new_word = i
        last_word = list[-1]

        if len(last_word) < len(new_word):
            small = last_word
            big = new_word
        else:
            small = new_word
            big = last_word

        for x in range(len(small)):
            if small[x] != big[x]:
                simpoints += 1

        simpoints += (len(big) - len(small))

        #print(simpoints)

        # Wert bestimmt die Toleranz
        #if simpoints >= 5:
            #list.append(new_word)

        percent = SequenceMatcher(None, last_word, new_word).ratio()
        if percent < 0.67:
            list.append(new_word)

        simpoints = 0


for l in list:
    outfile.write(l + "\n")


outfile.close()
file.close()
