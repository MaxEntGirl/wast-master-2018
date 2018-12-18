import string

wordlist = open("wordlist.txt", "w")
textfile = open("sammel.txt", "r", encoding="utf-8")
w_list = []

text = textfile.readlines()

for line in text:
    #print(line)
    tr = str.maketrans("", "", string.punctuation)
    line = line.translate(tr)
    #print(line)

    words = line.split()

    for word in words:
        #if word not in w_list:
        w_list.append(word)


print(w_list)
#w_list.sort()
print(w_list)
for word in w_list:
    wordlist.write(word)
    wordlist.write("\n")

wordlist.close()
textfile.close()
