#!/usr/bin/sh
#
outfile=whole_nachlass_text_files.txt
echo "Conatenate all NORM TEXT Files"
rm $outfile
find CISWAB/*/text -name "*OA_NORM*SIGLUM.txt" -print
find CISWAB/*/text -name "*OA_NORM*SIGLUM.txt" -exec cat {} >> $outfile \;
echo "Statistik Lines $outfile"
wc -l $outfile
echo "Statistik words $outfile"
wc -w $outfile
