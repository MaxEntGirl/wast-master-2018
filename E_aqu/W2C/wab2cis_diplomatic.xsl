<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:m="http://www.w3.org/1998/Math/MathML"
    exclude-result-prefixes="xs"
    version="2.0">
    
    
   <xsl:param name="show" select="'dipl'"/>
    <xsl:param name="text-only" select="false()" as="xs:boolean"/>
<!-- Max: 3/2017:  Pretty Print to enable Tagging -->
    <xsl:output indent="yes" encoding="UTF-8" method="xml" />

<!-- Max: 3/2017:  Change Newlines in the textoutput to Blanks, gives readable sentences -->
    <xsl:template match="text()">
        <xsl:value-of select='translate(., "&#xA;&apos;", "  ")' />
    </xsl:template>
    <xsl:include href="wab2cis.xsl"/>
    
</xsl:stylesheet>
