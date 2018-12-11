# Transformation der OpenAccess Files aus Bergen in Norm/Diplo/Text Files

# Achtung Installation des https://openjdk.java.net/
damit die XSLT Skripten funktionieren muss vorher der gesamt Java-Developer-Kit installiert werden.
Die Java Runtime Libaray reicht nicht.

# Transform OA XML Files into DIPLO, NORM and TXT Files

There is a `build.xml` File in the Directory with 3 targets:
```main target:  dist
    .... uses target transform
    
    target transform
    ... xstl Transformation into NORM and TXT Files```
    
**invoking** 
 * `ant     (starts default target `dist`)
 * `ant transform` (starts target `transform` and transforms latest Files into NORM and TEXT Versions)   

# Input/Output der Transformation
Die `.xml` Dateien aus: ` <property name="ciswab.oadir" value="./OAWAB"/>`
werden transformiert und nach 
`<property name="ciswab.outputdir" value="../ciswab/wab2cis/opensource_nachlass"/>` kopiert.

