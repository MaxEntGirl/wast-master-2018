<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:m="http://www.w3.org/1998/Math/MathML"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs m tei"
    version="2.0">
  
    <xsl:import href="wab2cis_siglum-text.xsl"/>
    <xsl:output method="xml" encoding="UTF-8" indent="no"/>
    <!--<xsl:strip-space elements="*"/>-->
    <xsl:strip-space elements="*"/>
    
    
    <xsl:template match="/">
        <xsl:element name="tei:TEI">
            <xsl:namespace name="m" select="'http://www.w3.org/1998/Math/MathML'"/>
            <xsl:namespace name="tei" select="'http://www.tei-c.org/ns/1.0'"/>
            <xsl:namespace name="" select="'http://www.tei-c.org/ns/1.0'"/>
            
        <xsl:apply-templates mode="text"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:teiHeader" mode="text">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:copy-of select="*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:body|tei:text" mode="text">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates mode="text"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:lb[not(attribute::node())]" mode="text">
        <xsl:text> </xsl:text>
    </xsl:template>
    
   <!-- overrides tei:ab in siglum text-->
    <xsl:template match="tei:ab" mode="text">
        <xsl:apply-templates mode="text"/>
    </xsl:template>
    <xsl:template match="tei:s" mode="text">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
        <xsl:variable name="phase1">
            <xsl:apply-templates mode="text"/>
        </xsl:variable> 
        <xsl:analyze-string select="$phase1" regex="^([^\n]+)$" flags="m">
            <xsl:matching-substring>
                <xsl:sequence select="normalize-space(replace(regex-group(1),'[&#x00A0;]\n',''))"/>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:sequence select="."></xsl:sequence>
            </xsl:non-matching-substring>
        </xsl:analyze-string>        
        </xsl:copy>
        <xsl:text>          
</xsl:text>
    </xsl:template>
    
</xsl:stylesheet>