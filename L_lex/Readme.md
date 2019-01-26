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
*       Das Script liest die Titel und Texte aus allen Dateien aus einem angegebenen Directory und speichert die gesammelten Resultate in die Datei Wortliste\sammel.txt
2. Wortliste\Wordlist.py
*       Das Script liest die gesammelten Texte von sammel.txt und extrahiert eine Wortliste, die in wordlist.txt gespeichert wird. 
*       In der Datei deleted_words.txt wurden manuell Wörter gespeichert, die nicht in der Wortliste gespeichert sein sollten (reine Zahlen).
*       In der Datei nice_word_list.txt wird die Wortliste ohne die gelöschten Wörter gespeichert.