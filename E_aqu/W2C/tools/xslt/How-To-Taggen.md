# wie man die Daten Tagged:


am einfachsten wäre folgendes: witt-data clonen und den Zweig
feature/expanded-diplo-tagging auschecken. Danach die Ordnerstruktur

CISWAB/geheim/secure_nachlass

nach ciswab/wab2cis/opensource_nachlass

kopieren (oder Symlink).

Dann in den Ordner deployment wechseln.

Dort als erstes

make download-tree-tagger

ausführen (Lizenz muss bestätigt werden, danach wird der TreeTagger
heruntergeladen).

Taggen der NORM Daten geht dann mit:

make tagged


Taggen der DIPLO Daten mit:

make expanded-diplo-tagged

Der Witz an dem make expanded-diplo-tagged Ziel ist, dass es vorher die
Alternativen ausmulitipliziert und dann taggt (wird mit Makefile Magie
gemacht).

Siehe auch README.md:
https://gitlab.cis.uni-muenchen.de/wast/witt-data/tree/feature/expanded-
diplo-tagging/deployment


Ich probiere das gleich mal lokal aus!
