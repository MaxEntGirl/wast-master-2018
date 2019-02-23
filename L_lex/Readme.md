# Lexikon L_lex

# Member sind (bitte eintragen, Name, email-adresse)
* für Aufgabe (1) ... Verena Pongratz
* Alexander Vordermaier, a.vordermaier@campus.lmu.de
* Di Wu  d.wu@campus.lmu.de

# Abgabetermin: zwischen 25.2. und 1.3.2019
* Präsentation als Gruppe (15 Minuten, jeder der Mitglieder 5 Minuten) und 
* Dokumentierte Programme im git-lab abgelegt 


# Aufgabenziele: 
* Erweiterung Briefwechsel
* Neue Wörter
* Semantische Suche
 *     Technik (python, [2])


* Event. Disambiguierung mit Parsing…  Nominalphrasen 
 * Spacy, Python, Dependenz-parsing

# (1) neue Aufgabe 13.12.18: Internationalisierung 
* neues Frontend Englisch ... und Lemmaliste fürs Lexikon


# Guide
1. Wortliste\Sammeldatei.py
*       Das Script liest die Titel und Texte aus allen Dateien aus einem übergebenen Directory und speichert die gesammelten Resultate in die Datei Wortliste\sammel.txt
2. Wortliste\Wordlist.py
*       Das Script liest die gesammelten Texte von sammel.txt und extrahiert eine Wortliste, die in wordlist.txt gespeichert wird. 
*       In der Datei deleted_words.txt wurden manuell Wörter gespeichert, die nicht in der Wortliste gespeichert sein sollten (reine Zahlen).
*       In der Datei nice_word_list.txt wird die Wortliste ohne die gelöschten Wörter gespeichert.
3.Vergleich mit Lexikon\extracting_new_words.py
*       Dieses Script vergleicht die erstellte Wortliste(die aus nice_word_list.txt) mit dem aktuellen Lexikon. Alle nicht vorkommenden Wörter werden in new_words.txt gespeichert
*       Die Wortliste aus Wortliste\nice_word_list.txt wurde in Vergleich mit Lexikon\word_candidates.txt kopiert um sie von dort einzulesen
4.Vergleich mit Lexikon\vergleich.py
*       In diesem Script werden die Wörter aus new_words.txt mit den von Dr. Hadersbeck gestellten Wortlisten aus brief_de_dela.txt und brief_en_dela.txt verglichen
*       Das Resultat wird in finale_Wortliste.txt gespeichert
*       Die Datei brief_de_dela.txt enthählt eine deutsche Wortliste
*       Die Datei brief_en_dela.txt enthählt eine englische Wortliste
5.Einteilung\einteilung.py
*       Dieses Script liest eine Wortliste aus Komplette_Wortliste.txt und das aktuelle Lexikon ein. 
*       Die Wortliste wird mit dem Lexikon verglichen. Wenn ein Wort bereits im Lexikon steht (Die Groß und Kleinschreibung wird nicht beachtet!), wird das Wort in die Datei unnötige_wörter.txt geschrieben. Der Rest in Restliste.txt

# Version 2

You will find more specific information in the comments of the individual scripts.

1. Wortliste\wordlist.py
*       The Script traverses a directory, the location is asked from the user. It will open all textfiles(letters) and will recognise the language of each file.
*       The Script builds a wordlist out of all textfiles and eich entry is provided with a languagetag. The result will be written in sammel.txt.
2. Lexikonvergleiche\compare.py
*		Copy the file sammel.txt and put in the directory Lexikonvergleiche.
*       The Script reads the wordlist from sammel.txt and compares it with the Wittlex and Cis-lex(Provided by Dr. Hadersbeck). All words that found in no lexicon, will be written in the files new_words_en.txt and new_words_de.txt
*       Words, that are neither english nor german, will be written in the file problem_words.txt.
*       Words that are inside the Lexica, but their spelling in Upper/Lowercase differs, will be saved in unnessecary_words.txt
3. Sort manually
*       You should look through the files and change things were you think a change would be appropriate.
4. Treetagger
*		The files new_words_en.txt and new_words_de.txt should be processed by a Treetagger to get the lemma of the words.
*		We used the Treetagger of Dr. Schmid for our work. You can find it here: http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/  
5. NeuesLexikon\cleaner.py
*       This script will put the parts of the CIS-Lex together into one file and deletes all entries that have a double appearance. For each case the smallest entry will be kept. The result will be saved in the file cleaned_words.txt.
5. NeuesLexikon\neu_sortieren.py
*       This script deletes all the unnessecary meta-data of the words and builds the first entries for the new Lexicon. The result will be saved in the file resorted_cleaned_words.