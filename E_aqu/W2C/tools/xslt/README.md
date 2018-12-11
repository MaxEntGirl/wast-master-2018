# Restlicher Nachlass 15000 Seiten

WAB2CIS
=======

XSL-Transformations from WAB to CIS TEI-XML-Format

Usage
-----

All Open Access WAB xml files used for the transformation can be found at their newest version at <http://wab.uib.no/cost-a32_xmlx/>.


This project delivers three different stylesheets:

a) a *normalized* xml transformation,
b) a *diplomatic* xml transformation and
c) a *text* transformation (based on the output of either normalized or diplomatic transformation)

All three transformations are fired off with the following flags:

* `-s`: sourcefolder or file
* `-xsl`: stylesheet
* `-o`: output folder/file

I normally run transformations through desktop applications, but have added a `.jar`-archive containing **Saxonica 9.4 Home Edition** in `saxon\saxon9pe.jar`

To kick off a transformation to *normalized*-Format do:

    java -jar "o:\git\wab2cis\saxon\saxon9pe.jar" -s:/o:/cost -xsl:/o:/git/wab2cis_normalized.xsl -o:/o:/git/wab2cis/CISWAB/norm/

To kick off a transformation to *diplomatic*-Format:

    java -jar "o:\git\wab2cis\saxon\saxon9pe.jar" -s:/o:/cost_32 -xsl:/o:/git/wab2cis_diplomatic.xsl -o:/o:/git/wab2cis/CISWAB/dipl/

To kick off a transformation to *text*-Format do:

    java -jar "o:\git\wab2cis\saxon\saxon9pe.jar" -s:/o:/git/wab2cis/CISWAB/norm/ -xsl:/o:/git/wab2cis_text.xsl -o:/o:/git/wab2cis/CISWAB/norm/text/


To kick off a transformation to *sentence text*-Format (every line one sentence) do:


    java -jar "o:\git\wab2cis\saxon\saxon9pe.jar" -s:/o:/git/wab2cis/CISWAB/norm/ -xsl:/o:/git/wab2cis_sentence-text.xsl -o:/o:/git/wab2cis/CISWAB/norm/text/


To kick off a transformation to *siglum Text*-Format do:

    java -jar "o:\git\wab2cis\saxon\saxon9pe.jar" -s:/o:/git/wab2cis/CISWAB/norm/ -xsl:/o:/git/wab2cis_siglum-text.xsl -o:/o:/git/wab2cis/CISWAB/norm/text/

Example output:

```xml
<s n="Ts-213,i-r[1]_1" ana="facs:Ts-213,i-r abnr:1 satznr:1"> Verstehen.</s>
<s n="Ts-213,i-r[2]_1" ana="facs:Ts-213,i-r abnr:2 satznr:2">1)Das Verstehen, die Meinung, fällt aus unsrer Betrachtung heraus.</s>
```


Author
------

Øyvind Liland Gjesdal <Oyvind.Gjesdal@ub.uib.no>
Max Hadersbeck, Okt 2016
