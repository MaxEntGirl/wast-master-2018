<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:variable name="outputDir">../output/</xsl:variable>
    <xsl:variable name="newline" select="'&#x0A;'"/>
    
    <xsl:template match="/">
        <xsl:for-each select="//tei:TEI[.//tei:persName[@role='sender' and @key='WittgensteinLudwig'] or .//tei:sourceDesc[contains(., 'Original im BA')]]">
            <xsl:variable name="path">
                <xsl:value-of select="$outputDir"/>
                <xsl:value-of select="@xml:id"/>
                <xsl:text>.txt</xsl:text>
            </xsl:variable>
            <xsl:result-document method="text" href="{$path}">
                <xsl:text>Siglum: </xsl:text>
                <xsl:value-of select="@xml:id"/>
                <xsl:value-of select="$newline"/>
                <xsl:value-of select="$newline"/>
                <xsl:text>Title: </xsl:text>
                <xsl:value-of select=".//tei:titleStmt/tei:title"/>
                <xsl:value-of select="$newline"/>
                <xsl:value-of select="$newline"/>
                <xsl:text>sourceDesc: </xsl:text>
                <xsl:value-of select=".//tei:sourceDesc"/>
                <xsl:value-of select="$newline"/>
                <xsl:value-of select="$newline"/>
                <xsl:text>Text: </xsl:text>
                <xsl:value-of select="$newline"/>
                <xsl:apply-templates select="./tei:text"></xsl:apply-templates>
                <xsl:value-of select="$newline"/>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="tei:text">
        <xsl:for-each select=".//tei:p">
            <xsl:value-of select="string(.)"/>
            <xsl:value-of select="$newline"/>
        </xsl:for-each>
    </xsl:template>
    
    
</xsl:stylesheet>