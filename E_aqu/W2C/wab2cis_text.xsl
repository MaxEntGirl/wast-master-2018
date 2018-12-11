<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">
    
    
    <!-- <xsl:preserve-space elements="*:s *:seg *:emph *:orig *:add *:del *:reg *:reloc"/>
   -->
    <xsl:include href="wabcis_templates.xsl"/>
    <xsl:output indent="no" encoding="UTF-8" method="text"/>
    <!-- Stylesheet to deliver text version of wab2cis tei output Use the output of norm or dipl stylesheet as input for this transformation.-->

    <!-- start transformation -->
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>    
    
    <xsl:template match="tei:TEI">
        <xsl:variable name="result-with-spaces">
            <xsl:apply-templates mode="text"/>
        </xsl:variable>
     <xsl:variable name="encapsulate-result">
        <xsl:analyze-string select="$result-with-spaces" regex="^([^\n]+)$" flags="m">
            <!-- Since we don't strip any spaces in content, there are alot of extra spaces present, from converting for instance newline to ' '. When we analyse the result in multiline, we can normalize each sentence, and then keep all \n which should be as expected.
              -->             
            <xsl:matching-substring>
                <xsl:sequence select="normalize-space((regex-group(1)))"/>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
     </xsl:variable>
        <xsl:value-of select="$encapsulate-result"/>
    </xsl:template>
        

   

<!--    <xsl:template match="tei:seg" mode="text">

        <xsl:if test="preceding-sibling::node()[1][(not(self::text()))]">
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:apply-templates mode="text"/>

    </xsl:template>-->

    <xsl:template match="tei:lb" mode="text">
<xsl:text>
</xsl:text>
    </xsl:template>
    
    <xsl:template match="tei:emph[@rend='space']" mode="text" priority="1.0">
        <xsl:variable name="emph-value"/>
        <xsl:for-each select="1 to string-length(.)">
            <xsl:value-of select="substring($emph-value,.,1)"/>
            <xsl:if test="not(last())">
           <xsl:text> </xsl:text>
            </xsl:if>
        </xsl:for-each>
        <xsl:apply-templates mode="text"/>
    </xsl:template>
    <xsl:template match="tei:pb" mode="text">
        <xsl:text>

</xsl:text>
        <xsl:value-of select="@facs"/>
        <xsl:text>

</xsl:text>
    </xsl:template>

    <!-- handles space between parallell language segments-->
    <xsl:template match="tei:seg[@part='N' and @xml:lang]" mode="text" priority="1.1">
        <xsl:apply-templates mode="text"/>
        <xsl:if test="exists(following-sibling::tei:seg[@part='N' and @xml:lang])"><xsl:text> </xsl:text></xsl:if>
    </xsl:template>
    
    <xsl:template match="tei:lb[matches(@rend,'shyphen','i')]" mode="text">
        <xsl:text>-</xsl:text>
        <xsl:text>
</xsl:text>
    </xsl:template>
    
    <xsl:template match="tei:seg[@rend='bitmap' or (matches(@corresp,'\.(je?pg|bmp|png)$') and @type='notation') and not(@xml:lang)]" mode="text" priority="1.2">
        <xsl:apply-templates mode="text"/>
        <xsl:if test="following-sibling::node()"><xsl:text> </xsl:text></xsl:if>
    </xsl:template>

    <xsl:template match="text()" mode="text">
              <xsl:value-of select="replace(.,'\n',' ')"/>
    </xsl:template>

    <!--  <xsl:template match="text()" mode="text">
        <xsl:if test="preceding-sibling::*:del and matches(.,'^[^\s]')">
            <xsl:text> </xsl:text>
        </xsl:if> 
        <xsl:next-match/>
    </xsl:template>-->

    <xsl:template match="*:del" mode="text"> </xsl:template>

    <xsl:template match="*[parent::*:choice]" mode="text">
        
        <xsl:apply-templates mode="text"/>
     <!--   <xsl:if test="not(preceding-sibling::*)">
            <xsl:text> </xsl:text>
        </xsl:if>-->
        <xsl:if test="exists(following-sibling::*)"><xsl:text> </xsl:text> </xsl:if>
    </xsl:template>
    
  <xsl:template match="tei:emph[exists(preceding-sibling::node())]" mode="text" priority="0.9">
        <xsl:apply-templates mode="text"/>
    </xsl:template>
   
    <xsl:template match="tei:space" mode="text">
        <xsl:call-template name="makeSpace">
            <xsl:with-param name="quantity" select="@quantity cast as xs:integer"/>
            <xsl:with-param name="unit" select="@unit"/>
        </xsl:call-template>
    </xsl:template>
    
    
    <xsl:template match="text()[matches(.,'^\s+$')]" mode="text">
        <xsl:text> </xsl:text>
    </xsl:template>
    
    <xsl:template match="tei:s" mode="text">
        <xsl:variable name="text">
        <xsl:apply-templates mode="text"/>
        </xsl:variable>
        <!-- analyzing sentence to normalize spacing in each line, without removing formatting space-->
        <xsl:analyze-string select="$text" regex="^([^\n]+)$" flags="m">
            <xsl:matching-substring>
                
                <xsl:value-of select="normalize-space(regex-group(1))"/>
               
            </xsl:matching-substring>
            <xsl:non-matching-substring>                
<xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
        <xsl:if test="matches(following::*[1]/string(.),'^[\w0-9]','i')"><xsl:text> </xsl:text></xsl:if>
       <!-- <xsl:if
            test="exists(following::tei:s[1]) and (following::tei:s[1] &lt;&lt; following::tei:lb[1] or following::tei:s[1] &lt;&lt; following::tei:pb[1])">
            <xsl:value-of select="' '"/>
        </xsl:if>-->

    </xsl:template>

    <xsl:template match="*:seg" mode="text">
        <xsl:apply-templates mode="text"/>
    </xsl:template>

</xsl:stylesheet>
