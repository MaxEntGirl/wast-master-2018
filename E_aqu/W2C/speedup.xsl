<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    
    <xsl:strip-space elements="* *:facsimilie *:surface *:graphics"/>
    <xsl:output indent="yes" encoding="UTF-8" method="xml" />
    <xsl:param name="show" select="'norm'"/>
    <!-- only using 'dipl' and 'norm' for max stylesheets
    Choices borrowed from Vemunds stylesheet for hmtl production -->
   
    <!-- start transformation -->
    <xsl:template match="/">
        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates/>
        </TEI>
    </xsl:template>
    
    <!-- matches to be ignored by stylesheet-->
    <!-- add elements and children to be ignored here-->
    <!--removed all lists after chat 12.11.2013 Max-->
    <!-- 14.11.13 OLG remove items unless they have sentence children? -->
    <!-- added different seg to remove-->
    
    <!--Start matches to be ignored by the stylesheet-->
    
    <!--removing   
        *:facsimilie
        *:item[not(exists(descendant::*:s))]
        *:seg[matches(@type,'^wabmarks-^int-ref|^edinst','i')]
        elements from output-->
    
 <!--   <xsl:template match="*:facsimilie|*:item[not(exists(descendant::*:s))]|*:seg[matches(@type,'^wabmarks-|^int-ref|^edinst','i')]"></xsl:template>
    -->
    <!--removing fw elements from all norm transformations-->
    <xsl:template match="*:fw[$show='norm']"></xsl:template> 
    
    <!-- removing fw element for all dipl -->
    <xsl:template match="*:fw[$show='dipl']"></xsl:template>
    
   <!-- removing *:corr[starts-with(@type,'npc')]-->
    <xsl:template match="*:corr[starts-with(@type,'npc')]"/>
    
    <!--Either strip or copy fw elements that for instance contains pagenumbering on the page Some fw elements are children of the body element-->
 
    <!--Removing orig element with type trsn1 than has a corr parent with trsn Other choice-->
 <!--   <xsl:template match="*:orig[@type='trsn1' and parent::*:corr[@type='trsn']]"></xsl:template>
    -->
    <!--Information outside sentences should be removed. An ab exists only of sentences, linebreaks or pagebreaks exists as children
        If a child of AB does not have a descendant s, pb or lb, ignore the entire path.-->
 <!--   <xsl:template match="*[parent::*:ab and (not(exists(descendant::*:s)) and not(exists(descendant::*:pb)) and not(exists(descendant::*:lb)))]"></xsl:template>
    -->
    <!--end matches to be ignored by the stylesheet-->
    
    <!--start matching rules-->
        
    <!--copy these tei:emph as is, and apply templates to children nodes-->
    <xsl:template match="tei:emph[matches(@rend,'(^us|^uw|^space|cap|^sub|^sup^)')]">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>       
        </xsl:copy>
    </xsl:template>
    
    <!--keep *:corr starts with @type 'tra' string-value-->
    <xsl:template match="*:corr[starts-with(@type,'tra')]">
        <xsl:value-of select="."/>
    </xsl:template>
    
     
    <!--OLG 14.11 attempt to choose always alt2. See 5. in e-mail-->
 <!--  checking if logic for choices, and last item covers orig   <xsl:template match="*:orig[exists(following-sibling::orig[@type='alt2']) or exists(preceding-sibling::orig[@type='alt2'])]"></xsl:template>
  --> 
    
    <!-- copy teiHeader as is. Should CIS get its own header based on the purpose and stripped version of the document? Should probably create a template that can be copied, with params for the different modes.-->
    <xsl:template match="*:teiHeader">
            <xsl:copy-of select="."/>
    </xsl:template>
    
    <!-- Ignoring attributes on body and text, but keeping the elements-->     
    <xsl:template match="*:body|*:text">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*:ab">
        <xsl:copy>
            <xsl:attribute name="n" select="(@n,@xml:id)[1]"/>
         <!--make ana attribute-->            
         <xsl:call-template name="ana"/>
         <xsl:apply-templates/>   
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*:s">
        <xsl:variable name="parent_ab" select="ancestor::*:ab"></xsl:variable>
       <xsl:copy>
           <xsl:attribute name="n">
              <xsl:value-of select="concat(ancestor::*:ab/(@n,@xml:id)[1],'_', count((preceding::*:s[ancestor::*:ab=$parent_ab],self::*:s)))"/> 
           </xsl:attribute>
           <xsl:call-template name="ana"/>
           <xsl:variable name="preceding-s" select="preceding::*:s[1]" as="node()*"/>
           <xsl:variable name="preceding-content-number" select="preceding::*:seg[@type='content_table-number'][1]"/>         
           <!-- checks if the seg is closer than the closest preceding s, and that the ancestor ab is the same
                if true, preceding:seg with content_table number is applied as text-only, to output the content table number at
                the preferred location-->
           <xsl:if test="((exists($preceding-s) 
               and $preceding-content-number > $preceding-s  
               and self::*:s[1]/ancestor::*:ab[1] = preceding::*:seg[@type='content_table-number'][1]/ancestor::*:ab[1]))
               or not(exists(preceding::*:s[1])) ">
               <xsl:apply-templates select="preceding::*:seg[@type='content_table-number'][1]" mode="text-only"/>
           </xsl:if>
           <xsl:apply-templates/>
       </xsl:copy>
    </xsl:template>
    
    
    <!-- do CIS want to keep rend/all attributes?-->
    <xsl:template match="*:lb">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*:pb">
        <xsl:copy>
            <xsl:copy-of select="@facs"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*" mode="text-only">
        <xsl:apply-templates/>
    </xsl:template>
    
 <!-- delete commented code? same rule as next with same element name, instead of <seg>-->   
  <!--  <xsl:template match="*:choice[parent::*:choice]">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>-->
    
    <!-- any element inside parent that isn't a choice will be made a <seg> with the old element name in the type attribute -->
    <xsl:template match="*[parent::*:choice]">
        <xsl:element name="seg"> 
            <xsl:attribute name="type" select="'stripped'"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <!--stripping seg[@type'q'] element and attributes -->
    <xsl:template match="*:seg[@type='q']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- All other elements are applied without keeping their own element tags.
        I.E if not specified anywhere else, elements and attributes will be stripped, and only text nodes will be fired (Lookup template="text()" match) 
    -->
    <xsl:template match="*">
        <xsl:apply-templates/>
    </xsl:template>
    
 
    <!-- in choice apply last child... no element choice is kept. This rule is overruled by more specific choice matches, see below. -->
    <xsl:template match="*:choice">
        <xsl:apply-templates select="child::node()[last()]"/>
    </xsl:template>
    
    <!-- handling tei_choice @type=s|s_h|s_S1, why is this is a different rule? For norm/dipl differences?-->
    <xsl:template match="tei:choice[@type='s']|tei:choice[@type='s_h']|tei:choice[@type='s_S1']">
       <xsl:copy>
           <xsl:copy-of select="@*"/>
           <xsl:call-template name="tei_choice_concat"/>
       </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:choice[@type='dsf']|tei:choice[@type='dsf_h']|tei:choice[@type='dsf_S1']">      
            <xsl:copy>
                <xsl:copy-of select="@*"/>
                <xsl:call-template name="tei_choice_concat"/>                
            </xsl:copy>           
    </xsl:template>
    
    <!-- handle tei_choice-->
    <xsl:template match="tei:choice[@type='dsl']|tei:choice[@type='dsl_h']|tei:choice[@type='dsl_H1']|tei:choice[@type='dsl_S1']|tei:choice[@type='dsl-em']">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:call-template name="tei_choice_concat"/>
        </xsl:copy>        
           </xsl:template>
    
    <!-- We replace the emph with blankspaces, with a space element-->
    <xsl:template match="*:emph[contains(@rend,'blankspace_')]">
        <xsl:variable name="quantity" select="tokenize(@rend,'\s')" as="xs:string*"/>            
        <xsl:for-each select="$quantity">
            <xsl:if test="matches(.,'^blankspace_([0-9]+)','i')">  
                <space quantity="{substring-after(.,'_')}" unit="chars"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>   

    <!-- start del element, specificied del elements that we want to keep.-->
    <xsl:template match="tei:del[@type='d']|tei:del[@type='d_c']|tei:del[@type='d_ch']|tei:del[@type='d_h']|tei:del[@type='d_H1']|tei:del[@type='d_h_ch']|tei:del[@type='d_S1']">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <!-- For now ignore tei:del elements that are not specified-->
    <xsl:template match="tei:del"></xsl:template>
    
    <!--copy seg as is, copy all attributes, and apply templates on children-->
    <xsl:template match="*:seg">
        <xsl:copy>
        <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Copy seg type notation as is, and apply children-->
    
    <xsl:template match="*:seg[@type='notation']">
        <xsl:copy>
            <xsl:copy-of select="@type"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>    
    
    <!--replacing newlines from text. TEI elements and objects will describe spacing and newlines -->
    <xsl:template match="text()">
        <xsl:value-of select="replace(.,'\n+','')"/>
    </xsl:template>
    
    <!--END template matches--> 
        
    <!--NAMED templates-->
    
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
    
    <!-- END NAMED templates-->
  
</xsl:stylesheet>