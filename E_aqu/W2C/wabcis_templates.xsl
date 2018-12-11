<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:w2c="http://data.ub.uib.no/wab2cis/"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <!--NAMED templates-->
    
    <xsl:template name="n">
        <xsl:variable name="parent_ab" select="ancestor::*:ab"></xsl:variable>
            <xsl:variable name="this.s" select="self::node()"/>
            <xsl:attribute name="n">
                <xsl:value-of select="concat(ancestor::*:ab[1]/(@n,@xml:id)[1],'_', count((ancestor::*:ab[.=$parent_ab]/descendant::*:s[. &lt;&lt; $this.s],self::*:s)))"/> 
            </xsl:attribute>
    </xsl:template>
    <!--NAMED template for specific choices, note that it is dependent on being called from within tei:choice-->
    <xsl:template name="tei_choice_concat">
        <xsl:for-each select="child::tei:orig">
            <xsl:element name="seg">
                <xsl:attribute name="n" select="concat(ancestor::tei:choice[1]/@type,'_alt',position())"/>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    
    <!--Named template ana to create ana attribute on diff-->
    <!--Suggestion to place values in ana in a similar manner to how Alois has used it, the TEI suggestion for multiple values in ana is seperating by space-->
    <xsl:template name="ana">
        <xsl:variable name="context" select="/"/>
        <xsl:variable name="ab_count" select="concat('abnr:',count((preceding::*:ab,self::*:ab,ancestor::*:ab)))"></xsl:variable>
        
        <xsl:attribute name="ana">  
            <xsl:choose>
                <xsl:when test="name(.)='ab'">
                    <xsl:value-of select="$ab_count"/>
                </xsl:when>
                <xsl:when test="name(.)='s'">
                    <xsl:variable name="facsimile">
                        <!--is this regex precise enough? non-greedy dot from start until [ is met? -->
                        <xsl:analyze-string select="(@n[string(.)],ancestor::*:ab/@xml:id[string(.)],ancestor::*:ab/@n[string(.)])[1]" regex="^(.+?)[\[\.]">
                            <xsl:matching-substring>
                                <xsl:value-of select="concat('facs:',w2c:facsname2facsImageName(regex-group(1),$context))"/>
                            </xsl:matching-substring>
                        </xsl:analyze-string>
                    </xsl:variable>
                    
                    <xsl:variable name="s_count" select="concat('satznr:',count((preceding::*:s,self::*:s)))"/>
                    <xsl:value-of select="normalize-space(concat($facsimile,' ',$ab_count,' ',$s_count))"/>
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
    
    <!-- replace function in oa_scenario: 
        replace(replace(replace(@xml:id,',','_'),'\]',''),'\[','.')
        
        We only need to reverse _ to , since [] are not used in pagenames
        Could also rewrite back, by  tokenizing segment based on "et", inserting ] before each token, and replacing "." with ] -->
    <xsl:function name="w2c:xmlname2imagename">
        <xsl:param name="xmlname"/>
        <xsl:value-of select="replace($xmlname,'_',',')"/>
    </xsl:function>
    
    <xsl:function name="w2c:facsname2facsImageName">
        <xsl:param name="facs"/>
        <xsl:param name="current-document" as="node()"/>
        <xsl:if test="not(id($facs,$current-document))">
            <xsl:message>Warning: @facs attribute <xsl:value-of select="$facs"/> not pointing at an xml:id.</xsl:message>
        </xsl:if>
        <xsl:variable name="fallback-name" select="w2c:xmlname2imagename($facs)"/>
        <!-- getting filename from url, by selecting token after last "/" and replacing everything after last \.-->          
        <!-- fallback to @facs if no @id match-->
        <xsl:attribute name="facs" select="(replace(tokenize(id($facs,$current-document)/tei:graphic/@url,'/')[last()],'\.[^.]+$','')[string(.)],$fallback-name)[1]"/>         
        
    </xsl:function>
    <!-- END NAMED templates-->
</xsl:stylesheet>
