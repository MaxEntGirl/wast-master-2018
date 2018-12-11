<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:m="http://www.w3.org/1998/Math/MathML"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:strip-space elements="* *:facsimilie *:surface *:graphics *:choice *:ab"/>
<!--    <xsl:preserve-space elements="*:seg *:emph *:orig *:add *:del *:reg *:reloc *:s"/>
-->    <xsl:param name="show" select="'norm'"/>
    
    <xsl:output indent="no" encoding="UTF-8" method="xml" />
    <xsl:include href="wab2cis.xsl"/>
    
</xsl:stylesheet>