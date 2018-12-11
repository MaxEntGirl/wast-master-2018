<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <!--NAMED templates-->
    
    <xsl:template name="n">
        <xsl:variable name="parent_ab" select="ancestor::*:ab"></xsl:variable>
      
            <xsl:attribute name="n">
                <xsl:value-of select="concat(ancestor::*:ab[1]/(@n,@xml:id)[1],'_', count((preceding::*:s[ancestor::*:ab=$parent_ab],self::*:s)))"/> 
            </xsl:attribute>
    </xsl:template>
    <!--NAMED template for specific choices, note that it is dependent on being called from within tei:choice-->
    <xsl:template name="tei_choice_concat">
        <xsl:for-each select="child::tei:orig">
            <xsl:element name="seg">
                <xsl:attribute name="n" select="concat(ancestor::tei:choice[1]/@type,'_alt',position())"/>
                <xsl:apply-templates/>
            </xsl:element>
            <!-- is not doing anything? why did I include this?-->
            <xsl:if test="following-sibling::tei:orig">                
            </xsl:if>         
        </xsl:for-each>
    </xsl:template>
    
    <!--Named template ana to create ana attribute on diff-->
    <!--Suggestion to place values in ana in a similar manner to how Alois has used it, the TEI suggestion for multiple values in ana is seperating by space-->
    <xsl:template name="ana">
        <xsl:variable name="ab_count" select="concat('abnr:',count((preceding::*:ab,self::*:ab,ancestor::*:ab)))"></xsl:variable>
        
        <xsl:attribute name="ana">  
            <xsl:choose>
                <xsl:when test="name(.)='ab'">
                    <xsl:value-of select="$ab_count"/>
                </xsl:when>
                <xsl:when test="name(.)='s'">
                    <xsl:variable name="facsimile">
                        <!--is this regex precise enough? non-greedy dot from start until [ is met? -->
                        <xsl:analyze-string select="(@n,ancestor::*:ab/@xml:id)[1]" regex="^(.+?)\[">
                            <xsl:matching-substring>
                                <xsl:value-of select="concat('facs:',regex-group(1))"/>
                            </xsl:matching-substring>
                        </xsl:analyze-string>
                    </xsl:variable>
                    <xsl:variable name="s_count" select="concat('satznr:',count((preceding::*:s,self::*:s)))"/>
                    <xsl:value-of select="concat($facsimile,' ',$ab_count,' ',$s_count)"/>
                </xsl:when>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template name="makeSpace">
        <xsl:param name="quantity" as="xs:integer"/>
        <xsl:param name="unit"/>
        <xsl:choose>
            <xsl:when test="$unit='chars'">
                <xsl:for-each select="1 to $quantity">
                    <xsl:text>&#x00A0;</xsl:text>
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>  
        
    </xsl:template>
    
    <!-- END NAMED templates-->
</xsl:stylesheet>
