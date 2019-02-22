# Dieses Skript durchläuft ein Verzeichnis und extrahiert alle Titel und Texte aus allen Dateien 
# innerhalb des Verzeichnisses, den Ort des Verzeichnisses frägt das Verzeichnis ab.
# Der Ort sollte in dieser Art angegeben werden: Desktop/Seminar/wast-master-2018/E_Brief/FIBA2CIS/output/text
# Die Ergebnisse werden in eine einzige Datei geschrieben, um alle Informationen an einem Ort zu sammeln



from os import walk
import re
import codecs

sammelfile = open("sammel.txt", "w")
name = []
dir = input('Enter Location of letters: ')

# Um das Verzeichnis zu durchsuchen, übergibt man der Walk-Funktion einfach den Ort des Verzeichnisses, das man durchsuchen möchte
#for path, drive, name in walk('/home/v/vordermaier/Desktop/Seminar/wast-master-2018/E_Brief/FIBA2CIS/output/text'):
    #print(name)
for path, drive, name in walk(dir):
    print("Searching Directory...")

# Extraktion der Tietel und Texte
# Das Resultat wird in die Datei Wortliste\sammel.txt geschrieben
for i in name:
    print(i)
	#Übergebe den Ort des Verzeichnisses(den selben wie vorher) + der aktuelle Dateiname i, um die Dateien zu öffnen
    file = codecs.open(dir + "/" + i, 'r')
    text = file.read()
    text = text.replace("\n", " ")

	# Extraktion der Tietel
    result = re.search('Title:(.*)sourceDesc:', text)
    sammelfile.write(result.group(1))
    sammelfile.write("\n")

	#Extraktion der Texte
    result = re.search('Text:(.*)',text)
    sammelfile.write(result.group(1))
    sammelfile.write("\n")
    sammelfile.write("\n")

    file.close()

sammelfile.close()

