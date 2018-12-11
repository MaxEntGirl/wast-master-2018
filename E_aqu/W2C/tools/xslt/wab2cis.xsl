<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:m="http://www.w3.org/1998/Math/MathML"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:include href="wabcis_templates.xsl"/>
    <xsl:strip-space elements="*:facsimile"/>
    <xsl:output indent="no" encoding="UTF-8" method="xml" />
    <!-- only using 'dipl' and 'norm' for max stylesheets
    Choices borrowed from Vemunds stylesheet for hmtl production -->
    <!-- start transformation -->
    <xsl:template match="/">
    
        <TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:m="http://www.w3.org/1998/Math/MathML">
            <xsl:apply-templates/>
        </TEI>
            
            <!--firing transformation for text only if param text-only is on, and parameter is norm-->
         
    </xsl:template>
    


    <!-- matches to be ignored by stylesheet-->
    <!-- add elements and children to be ignored here-->
    <!--removed all lists after chat 12.11.2013 Max-->
    <!-- 14.11.13 OLG remove items unless they have sentence children? -->
    <!-- added different seg to remove-->
    
    <!--Start matches to be ignored by the stylesheet-->
    
   
    
 <!--   <xsl:template match="" priority="1.0"></xsl:template>-->
    <!--removing   
        *:facsimilie
        *:item[not(exists(descendant::*:s))]
        *:seg[matches(@type,'^wabmarks-^int-ref|^edinst','i')]
        elements from output-->
    <!--removing fw elements from all norm transformations-->
    <!--to remove strange signs from versions-->
    <!-- removing fw element for all dipl -->
    <!--Information outside sentences should be removed. An ab exists only of sentences, linebreaks or pagebreaks exists as children
        If a child of AB does not have a descendant s, pb or lb, ignore the entire path.-->
   
    <xsl:template match="*:fw[$show='norm']|
        *:facsimilie|
        *:item[not(exists(descendant::*:s))]|
        *:seg[matches(@type,'^wabmarks-|^int-ref|^edinst','i')]|
        tei:seg[@type='edinst']|
        *:fw[$show='dipl']|
        *[parent::*:ab and (not(exists(descendant-or-self::*:s)) and not(exists(descendant-or-self::*:pb)) and not(exists(descendant-or-self::*:lb)))] |*:seg[@type='content_table-number']" xml:space="default" priority="0.9" />
    
     
    
   <!-- removing *:corr[starts-with(@type,'npc')] for norm-->
    <xsl:template match="*:corr[starts-with(@type,'npc')]" priority="0.8">
        <xsl:choose>
            <xsl:when test="$show='norm'"></xsl:when>
            <xsl:when test="$show='dipl'">
                <xsl:apply-templates/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!-- corr type trs-->
    
    <xsl:template match="*:corr[@type='trs']" priority="1.0">
        <xsl:choose>
            <xsl:when test="$show='norm'">
                <xsl:apply-templates select="child::*[@type='trs2']"/>
            </xsl:when>
            <xsl:when test="$show='dipl'">
                <xsl:apply-templates select="child::*[@type='trs1']"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!--Either strip or copy fw elements that for instance contains pagenumbering on the page Some fw elements are children of the body element-->
 
    <!--Removing orig element with type trsn1 than has a corr parent with trsn Other choice-->
    <xsl:template match="*:orig[@type='trsn1' and parent::*:corr[@type='trsn']]" priority="1.0">
        <xsl:choose>
            <xsl:when test="$show='norm'"></xsl:when>
            <xsl:when test="$show='dipl'"><xsl:apply-templates/></xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!-- Adding explicit mapping for trsn2, removing it for diplomatic view-->
    <xsl:template match="*:reg[@type='trsn2' and parent::*:corr[@type='trsn']]" priority="1.0">
        <xsl:choose>
            <xsl:when test="$show='norm'"><xsl:apply-templates/></xsl:when>
            <xsl:when test="$show='dipl'"></xsl:when>
        </xsl:choose>
    </xsl:template>
    
      
    <!--end matches to be ignored by the stylesheet-->
    
    <!--start matching rules-->
        
    <!--copy these tei:emph as is, and apply templates to children nodes-->
    <xsl:template match="tei:emph[matches(@rend,'(^us|^uw|^space|cap|^sub|^sup^)')]" priority="1.0">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>       
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:abbr" priority="1.0">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
        
    </xsl:template>
    <!--keep *:corr starts with @type 'tra' string-value-->
    <xsl:template match="*:corr[starts-with(@type,'tra')]" priority="1.0">
      <xsl:choose>
          <xsl:when test="$show='norm'">
              <xsl:apply-templates/>
          </xsl:when>
          <xsl:when test="$show='dipl'"/>
      </xsl:choose>
     
    </xsl:template>
    
     
    <!--OLG 14.11 attempt to choose always alt2. See 5. in e-mail-->
 <!--  checking if logic for choices, and last item covers orig   <xsl:template match="*:orig[exists(following-sibling::orig[@type='alt2']) or exists(preceding-sibling::orig[@type='alt2'])]"></xsl:template>
  --> 
    
    <!-- copy teiHeader as is. Should CIS get its own header based on the purpose and stripped version of the document? Should probably create a template that can be copied, with params for the different modes.-->
    <xsl:template match="*:teiHeader" priority="1.0">
            <xsl:copy-of select="."/>
    </xsl:template>
    
    <!-- Ignoring attributes on body and text, but keeping the elements-->     
    <xsl:template match="*:body|*:text" priority="1.0">
        <xsl:copy xml:space="preserve">
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*:ab" priority="1.0" >
        <xsl:copy>
            <xsl:attribute name="n" select="(@n,@xml:id)[1]"/>
           
         <!--make ana attribute-->            
         <xsl:call-template name="ana"/>
         <xsl:apply-templates/>   
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*:s" priority="1.0">
        <xsl:variable name="parent_ab" select="ancestor::*:ab"/>
       <xsl:copy>
           <xsl:attribute name="n">
              <xsl:value-of select="concat(ancestor::*:ab[1]/(@n,@xml:id)[1],'_', count((preceding::*:s[ancestor::*:ab=$parent_ab],self::*:s)))"/> 
           </xsl:attribute>
           <xsl:call-template name="n"/>
           <xsl:call-template name="ana"/>
           <xsl:variable name="preceding-s" select="(preceding::*:s[1])[1]" as="node()*"/>
           <xsl:variable name="preceding-content-number" select="preceding::*:seg[@type='content_table-number'][1]"/>         
           <!-- checks if the seg is closer than the closest preceding s, and that the ancestor ab is the same
                if true, preceding:seg with content_table number is applied as text-only, to output the content table number at
                the preferred location-->
           <xsl:if test="(($preceding-content-number >> $preceding-s or not(exists(preceding::*:s[1]))  
               and self::*:s[1]/ancestor::*:ab[1] = preceding::*:seg[@type='content_table-number'][1]/ancestor::*:ab[1]))
                ">
               <xsl:apply-templates select="preceding::*:seg[@type='content_table-number'][1]" mode="text-only"/>
           </xsl:if>
           <xsl:apply-templates/>
       </xsl:copy>
    </xsl:template>
    
    
    <!-- do CIS want to keep rend/all attributes?-->
    <xsl:template match="*:lb" priority="1.0">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*:pb" priority="1.0">
        <xsl:copy>
            <xsl:copy-of select="@facs"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
   
    
    <xsl:template match="*" mode="text-only">
<xsl:value-of select="."/>
    </xsl:template>
    
 <!-- delete commented code? same rule as next with same element name, instead of <seg>-->   
  <!--  <xsl:template match="*:choice[parent::*:choice]">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>-->
    
    <!-- any element inside parent that isn't a choice will be made a <seg> with the stripped name in the type attribute -->
    <xsl:template match="*[parent::*:choice]" priority="1.0">
        <xsl:element name="seg"> 
            <xsl:attribute name="type" select="'stripped'"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <!--stripping seg[@type'q'] element and attributes -->
    <xsl:template match="*:seg[@type='q']" priority="1.0">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- All other elements are applied without keeping their own element tags.
        I.E if not specified anywhere else, elements and attributes will be stripped, and only text nodes will be fired (Lookup template="text()" match) 
    -->
    <xsl:template match="*" priority="0.6">
        
        <xsl:apply-templates/>
        <xsl:if test="matches(following-sibling::node()[1],'^\n$')">
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>
    
 
    <!-- in choice apply last child... no element choice is kept. This rule is overruled by more specific choice matches, see below. -->
    <xsl:template match="*:choice" priority="0.8">
        <xsl:apply-templates select="child::node()[last()]"/>
 <!--   <xsl:text> </xsl:text>-->
    </xsl:template>
    
    <!-- handling tei_choice @type=s|s_h|s_S1, why is this is a different rule? For norm/dipl differences?-->
    <xsl:template match="tei:choice[@type='s']|tei:choice[@type='s_h']|tei:choice[@type='s_S1']" priority="1.0">
       <xsl:copy>
           <xsl:copy-of select="@*"/>
           <xsl:call-template name="tei_choice_concat"/>
       </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:choice[@type='dsh' and $show='norm']" priority="1.0">
        <xsl:apply-templates select="*[position()=1]"/>
    </xsl:template>
    
    <xsl:template match="tei:choice[@type='dsf']|tei:choice[@type='dsf_h']|tei:choice[@type='dsf_S1']" priority="1.0">      
        <xsl:choose>
            <xsl:when test="$show='dipl'"> <xsl:copy>
                <xsl:copy-of select="@*"/>
                <xsl:call-template name="tei_choice_concat"/>                
            </xsl:copy>    
            </xsl:when>
            <xsl:when test="$show='norm'">
               <xsl:apply-templates select="*[position()=1]"/>
            </xsl:when>
        </xsl:choose> 
              
    </xsl:template>
    
    <!-- handle tei_choice-->
    <xsl:template match="tei:choice[@type='dsl']|tei:choice[@type='dsl_h']|tei:choice[@type='dsl_H1']|tei:choice[@type='dsl_S1']|tei:choice[@type='dsl-em']">
        <xsl:choose>
            <xsl:when test="$show='dipl'">
                <xsl:copy>
                    <xsl:copy-of select="@*"/>
                    <xsl:call-template name="tei_choice_concat"/>
                </xsl:copy> 
            </xsl:when>
            <xsl:when test="$show='norm'">
                <xsl:apply-templates select="*[position()=last()]"/>
            </xsl:when>
        </xsl:choose>
         
           </xsl:template>
    
    <!-- We replace the emph with blankspaces, with a space element-->
    <xsl:template match="*:emph[contains(@rend,'blankspace_')]" priority="0.8">
        <xsl:variable name="quantity" select="tokenize(@rend,'\s')" as="xs:string*"/>            
        <xsl:for-each select="$quantity">
            <xsl:if test="matches(.,'^blankspace_([0-9]+)','i')">  
                <space quantity="{substring-after(.,'_')}" unit="chars"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>   

    <!-- start del element, specificied del elements that we want to keep.-->
    <xsl:template match="tei:del[@type='d']|tei:del[@type='d_c']|tei:del[@type='d_ch']|tei:del[@type='d_h']|tei:del[@type='d_H1']|tei:del[@type='d_h_ch']|tei:del[@type='d_S1']" priority="0.8">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <!-- For now ignore tei:del elements that are not specified, also text mode-->
    <xsl:template match="tei:del" mode="#all" priority="0.7"></xsl:template>
    
    <!--copy seg as is, copy all attributes, and apply templates on children-->
    <xsl:template match="*:seg" priority="0.7">
        <xsl:copy>
        <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Copy seg type notation as is, and apply children-->
    
    <xsl:template match="*:seg[@type='notation']" priority="0.8">
        <xsl:copy>
            <xsl:copy-of select="@type"/>
            <xsl:copy-of select="@corresp"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>    
    
    <!--END template matches--> 
        
</xsl:stylesheet>