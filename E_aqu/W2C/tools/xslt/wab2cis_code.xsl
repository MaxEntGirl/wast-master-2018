<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:m="http://www.w3.org/1998/Math/MathML"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:import href="wab2cis.xsl"/>
    <xsl:strip-space elements="*:facsimilie *:surface *:graphics *:choice "/>
    <xsl:preserve-space elements="*:s *:seg *:emph *:orig *:add *:del *:reg *:reloc *:ab"/>
    <xsl:param name="show" select="'norm'"/>
    
    <xsl:output indent="yes" encoding="UTF-8" method="xml" />
    
    <xsl:template match="/">
        <tei:TEI>
            <teiHeader type="text">
                <fileDesc>
                    <titleStmt>
                        <title xml:id="wab-all-code" xml:lang="en">Coded statements in Wab Nachlass from Wab-0 to Wab-rest files.</title>
                        <author>Ludwig Wittgenstein</author>
                        <editor role="editor">
                            <persName full="yes">Alois Pichler</persName>
                            <orgName ref="http://wab.uib.no/" full="yes">Wittgenstein Archives at the University of Bergen
                                (WAB)</orgName>
                        </editor>
                     </titleStmt>
                    <publicationStmt>
                        
                        <idno type="URL">http://wab.uib.no/wab_hw.page/</idno>
                        <availability xml:lang="en" default="false" status="unknown">
                            <p>Copyright holders: The Master and Fellows of Trinity College, Cambridge; <!--Oxford University Press, Oxford;--> University of Bergen, Bergen. Released under the Creative Commons General
                                Public License Attribution, Non-Commercial, Share-Alike version 3 (CCPL BY-NC-SA).</p>
                        </availability>
                    </publicationStmt>
                    <sourceDesc xml:lang="en" default="false">
                        <p>All codes by wittgenstein</p>
                    </sourceDesc>
                </fileDesc>
                <profileDesc>
                   
                </profileDesc>
                <revisionDesc>

                </revisionDesc>
            </teiHeader>
        <tei:text><tei:body>
            <xsl:apply-templates select="descendant::*:file"/>
        </tei:body></tei:text>
        </tei:TEI>
    </xsl:template>
    
    <xsl:template match="*:file">
        <xsl:apply-templates select="document(@name)/descendant::tei:body"/>
    </xsl:template>
        
    <xsl:template match="tei:teiHeader"></xsl:template>
    
    <xsl:template match="tei:body|tei:text">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:ab">
        <xsl:if test="@seg='code' or descendant::tei:seg[@type='code']">
            <xsl:next-match/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="tei:s">
        <xsl:choose>
            <xsl:when test="ancestor::tei:ab[1]/@seg='code' or ancestor::tei:seg[@type='code']">
                <xsl:next-match/>
            </xsl:when>
            <xsl:when test="descendant::tei:seg[@type='code']">
                   
                <xsl:copy>
                    <xsl:call-template name="n"/>
                    <xsl:call-template name="ana"/>
                <xsl:apply-templates select="descendant::tei:seg[@type='code']"/>
                </xsl:copy>
            </xsl:when>
            
            
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:seg[@type='code']">
        <xsl:if test="preceding-sibling::*[1]">
            <xsl:text>...</xsl:text>
        </xsl:if>
        <xsl:next-match/>
        <xsl:if test="following-sibling::*[1]">
            <xsl:text>...</xsl:text>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>