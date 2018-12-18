from os import walk
import re
import codecs

sammelfile = open("sammel.txt", "w")
name = []

for path, drive, name in walk('C:/Users/alexv/Desktop/wast-master-2018/E_Brief/FIBA2CIS/output/text'):
    print(name)


for i in name:
    print(i)
    file = open('C:/Users/alexv/Desktop/wast-master-2018/E_Brief/FIBA2CIS/output/text/' + i, 'r');#errors='ignore'
    #file = codecs.open('C:/Users/alexv/Desktop/wast-master-2018/E_Brief/FIBA2CIS/output/text/' + i, 'r')
    text = file.read()
    text = text.replace("\n", " ")

    sammelfile.write(i)
    sammelfile.write("\n")

    result = re.search('Title:(.*)sourceDesc:', text)
    sammelfile.write(result.group(1))
    sammelfile.write("\n")

    result = re.search('Text:(.*)',text)
    sammelfile.write(result.group(1))
    sammelfile.write("\n")
    sammelfile.write("\n")

    file.close()

sammelfile.close()

