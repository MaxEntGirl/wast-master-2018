<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">

    <xsl:import href="wab2cis_text.xsl"/>
    <!--<xsl:strip-space elements="*"/>-->
    <xsl:preserve-space elements="* *:ab *:emph *:orig *:add *:del *:reg *:reloc *:s"/>
    <xsl:template match="/">
        <!--adding all output to a variable to normalize spaces on output -->
        
            <xsl:apply-templates mode="text"/>
       
            
  <!--      <xsl:analyze-string select="$phase-1" regex="^(.+)$" flags="m">
            <xsl:matching-substring>
                <xsl:sequence select="normalize-space(replace(regex-group(1),'[&#x00A0;]',' '))"/>
            </xsl:matching-substring>
        </xsl:analyze-string>-->     
    </xsl:template>
    
    
 <!--   <xsl:template match="tei:ab[descendant::choice]">
        <xsl:variable name="elements">
            <xsl:variable name="count" select="count(descendant::choice)"></xsl:variable>
<xsl:for-each select="descendant::choice/*">
  
</xsl:for-each>            
        </xsl:variable>      
        <xsl:variable name="first" select="descendant::choice"></xsl:variable>
    </xsl:template>-->
    
<!--    <xsl:template match="*" mode="version">
        <xsl:param name="position"/>
        <xsl:apply-templates select="ancestor::tei:ab">
            <xsl:with-param name="positions" select="$position"></xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>-->
    
    
    <xsl:template match="tei:lb[@rend='shyphen']|tei:pb[@rend='shyphen']|tei:lb['shyphen-pb']|tei:pb[preceding-sibling::*[1][matches(@rend,'shyphen','i')]]" priority="1.0" mode="text"></xsl:template>
    <xsl:template match="tei:lb[not(@rend='shyphen')]" mode="text">
        <xsl:text> </xsl:text></xsl:template>

    <xsl:template match="tei:pb[not(@rend='shyphen')and not(preceding-sibling::*[1][matches(@rend,'shyphen','i')])]" priority="0.9" mode="text"><xsl:text> </xsl:text></xsl:template>


    <xsl:template match="tei:ab" mode="text">
    
<xsl:text>
</xsl:text>
  
  <xsl:variable name="phase1">  <xsl:value-of select="concat(@n,';')"/>
        <xsl:apply-templates mode="text"/>
      </xsl:variable> 
        <xsl:analyze-string select="$phase1" regex="^(.+)$" flags="m">
          <xsl:matching-substring>
              <xsl:sequence select="normalize-space(replace(regex-group(1),'[&#x00A0;]\n',''))"/>
          </xsl:matching-substring>
      </xsl:analyze-string>  
    </xsl:template>
    
    <xsl:template match="*:seg[@rend='bitmap' or (matches(@corresp,'\.(je?pg|bmp|png)$') and @type='notation')]" mode="#all"></xsl:template>
    <!-- Remove <seg type="wabmarks-secml" part="N">​</seg> -->
    <xsl:template match="tei:seg[@type='wabmarks-secml']" mode="text">
    </xsl:template>
    
    <xsl:template match="tei:teiHeader" mode="text"></xsl:template>
</xsl:stylesheet>
