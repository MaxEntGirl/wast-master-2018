<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:variable name="outputDir">../output/xml/</xsl:variable>
    <xsl:variable name="newline" select="'&#x0A;'"/>
    
    <xsl:template match="/">
        <xsl:for-each select="//tei:TEI[.//tei:persName[@role='sender' and @key='WittgensteinLudwig'] or .//tei:sourceDesc[contains(., 'Original im BA')]]">
            <xsl:variable name="path">
                <xsl:value-of select="$outputDir"/>
                <xsl:value-of select="@xml:id"/>
                <xsl:text>.xml</xsl:text>
            </xsl:variable>
            <xsl:result-document method="xml" href="{$path}">
                <xsl:copy-of select="."/>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>