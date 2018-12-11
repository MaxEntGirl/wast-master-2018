<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:m="http://www.w3.org/1998/Math/MathML"
    xmlns:w2c="http://data.ub.uib.no/wab2cis/"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    <xsl:include href="wabcis_templates.xsl"/>

    
    <xsl:preserve-space elements="*"/>
    <!-- Defined in the NORM and DIPLO Stylesheet:  xsl:output indent="no" encoding="UTF-8" method="xml" /-->
    <!-- only using 'dipl' and 'norm' for max stylesheets
    Choices borrowed from Vemunds stylesheet for hmtl production -->
    <!-- start transformation -->
    <xsl:template match="/">         
            <xsl:apply-templates/>
    </xsl:template>
        
    <xsl:template match="tei:TEI" priority="2.0">  
        <xsl:variable name="wab2cis-result">  
        <xsl:copy
            ><xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>    
        </xsl:variable>
        <xsl:apply-templates select="$wab2cis-result" mode="strip-extra-spacing"/>
    </xsl:template>

    <!-- matches to be ignored by stylesheet-->
    <!-- add elements and children to be ignored here-->
    <!--removed all lists after chat 12.11.2013 Max-->
    <!-- 14.11.13 OLG remove items unless they have sentence children? -->
    <!-- added different seg to remove-->
    
    <!--Start matches to be ignored by the stylesheet-->
    
    <!--removing   
        tei:facsimilie
        tei:item[not(exists(descendant::tei:s))]
        tei:seg[matches(@type,'^wabmarks-^int-ref|^edinst','i')]
        elements from output-->
    <!--removing fw elements from all norm transformations-->
    <!--to remove strange signs from versions-->
    <!-- removing fw element for all dipl -->
    <!--Information outside sentences should be removed. An ab exists only of sentences, linebreaks or pagebreaks exists as children
        If a child of AB does not have a descendant s, pb or lb, ignore the entire path.-->
   
    <xsl:template match="tei:fw[$show='norm']|
        tei:facsimile|
        tei:item[not(exists(descendant::tei:s))]|
        tei:seg[matches(@type,'^wabmarks-|^int-ref|^edinst','i')]|        
        tei:fw[$show='dipl']|
        *[parent::tei:ab and (not(exists(descendant-or-self::tei:s)) and not(exists(descendant-or-self::tei:pb)) and not(exists(descendant-or-self::tei:lb)))] 
        |tei:seg[@type='content_table-number']" priority="0.9" />
     
   <!-- removing tei:corr[starts-with(@type,'npc')] for norm-->
    <xsl:template match="tei:corr[starts-with(@type,'npc')]" priority="0.8">
        <xsl:choose>
            <xsl:when test="$show='norm'"></xsl:when>
            <xsl:when test="$show='dipl'">
                <xsl:apply-templates/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!-- corr type trs-->
    
    <xsl:template match="tei:corr[@type='trs']" priority="1.0">
        <xsl:choose>
            <xsl:when test="$show='norm'">
                <xsl:apply-templates select="child::*[@type='trs2']"/>
            </xsl:when>
            <xsl:when test="$show='dipl'">
                <xsl:apply-templates select="child::*[@type='trs1']"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
 
    <!-- corr type trco-->
    
    <xsl:template match="tei:corr[@type='trco']" priority="1.0">
        <xsl:choose>
            <xsl:when test="$show='norm'">
                <xsl:apply-templates select="child::*[@type='trco2']"/>
            </xsl:when>
            <xsl:when test="$show='dipl'">
                <xsl:apply-templates select="child::*[@type='trco1']"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
 
 
 <!--Either strip or copy fw elements that for instance contains pagenumbering on the page Some fw elements are children of the body element-->
 
    <!--Removing orig element with type trsn1 than has a corr parent with trsn Other choice-->
    <xsl:template match="tei:orig[@type='trsn1' and parent::tei:corr[@type='trsn']]" priority="1.0">
        <xsl:choose>
            <xsl:when test="$show='norm'"></xsl:when>
            <xsl:when test="$show='dipl'"><xsl:apply-templates/></xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!-- Adding explicit mapping for trsn2, removing it for diplomatic view-->
    <xsl:template match="tei:reg[@type='trsn2' and parent::tei:corr[@type='trsn']]" priority="1.0">
        <xsl:choose>
            <xsl:when test="$show='norm'"><xsl:apply-templates/></xsl:when>
            <xsl:when test="$show='dipl'"></xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!--end matches to be ignored by the stylesheet-->
    
    <!--start matching rules-->
        
    <!--copy these tei:emph as is, and apply templates to children nodes -->
    <!--ORIG:template match="tei:emph[matches(@rend,'(^us|^uw|^space|^cap|^sub|^sup)')]" priority="1.0" -->
    <!-- MAX, 17: REMOVE ^us  and ^uw --> 
    <xsl:template match="tei:emph[matches(@rend,'(^space|^cap|^sub|^sup)')]" priority="1.0">
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
    <!--keep tei:corr starts with @type 'tra' string-value-->
    <xsl:template match="tei:corr[starts-with(@type,'tra')]" priority="1.0">
      <xsl:choose>
          <xsl:when test="$show='norm'">
              <xsl:apply-templates/>
          </xsl:when>
          <xsl:when test="$show='dipl'"/>
      </xsl:choose>     
    </xsl:template>
    
     
    <!--OLG 14.11 attempt to choose always alt2. See 5. in e-mail-->
 <!--  checking if logic for choices, and last item covers orig   <xsl:template match="tei:orig[exists(following-sibling::orig[@type='alt2']) or exists(preceding-sibling::orig[@type='alt2'])]"></xsl:template>
  --> 
    
    <!-- copy teiHeader as is. Should CIS get its own header based on the purpose and stripped version of the document? Should probably create a template that can be copied, with params for the different modes.-->
    <xsl:template match="tei:teiHeader" priority="1.0">
            <xsl:copy-of select="."/>
    </xsl:template>
    
    <!-- Ignoring attributes on body and text, but keeping the elements-->     
    <xsl:template match="tei:body|tei:text" priority="1.0">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:ab" priority="1.0" >
        <xsl:copy>
            <xsl:attribute name="n" select="(@n,@xml:id)[1]"/>
           
         <!--make ana attribute-->            
         <xsl:call-template name="ana"/>
         <xsl:apply-templates/>   
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:s" priority="1.0">
        <xsl:variable name="parent_ab" select="ancestor::tei:ab"/>
       <xsl:copy>
           <xsl:call-template name="n"/>
           <xsl:call-template name="ana"/>
           <xsl:variable name="preceding-s" select="(preceding::tei:s[1])[1]" as="node()*"/>
           <xsl:variable name="preceding-content-number" select="preceding::tei:seg[@type='content_table-number'][1]"/>         
           <!-- checks if the seg is closer than the closest preceding s, and that the ancestor ab is the same
                if true, preceding:seg with content_table number is applied as text-only, to output the content table number at
                the preferred location-->
           <xsl:if test="(($preceding-content-number >> $preceding-s or not(exists(preceding::tei:s[1]))  
               and self::tei:s[1]/ancestor::tei:ab[1] = preceding::tei:seg[@type='content_table-number'][1]/ancestor::tei:ab[1]))
                ">
               <xsl:apply-templates select="preceding::tei:seg[@type='content_table-number'][1]" mode="text-only"/>
               <xsl:if test="not(matches(preceding::tei:seg[@type='content_table-number'][1],'\s+$'))"><xsl:text> </xsl:text></xsl:if>
           </xsl:if>
           <xsl:apply-templates/>
       </xsl:copy>
    </xsl:template>   
    
    <!-- do CIS want to keep rend/all attributes?-->
    <xsl:template match="tei:lb" priority="1.0">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:pb" priority="1.0">
        
        <xsl:copy>              
            <xsl:attribute name="facs" select="w2c:facsname2facsImageName(@facs,/)"/>         
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
     
    <xsl:template match="*" mode="text-only">
<xsl:value-of select="."/>
    </xsl:template>

    <!-- any element inside parent that isn't a choice will be made a <seg> with the stripped name in the type attribute -->
        <!-- corr type o1 or o2 -->

   
    <xsl:template match="*[parent::tei:choice]" priority="1.0">
        <xsl:element name="seg"> 
            <xsl:attribute name="type" select="'stripped'"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <!--stripping seg[@type'q'] element and attributes -->
    <xsl:template match="tei:seg[@type='q']" priority="1.0">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- All other elements are applied without keeping their own element tags.
        I.E if not specified anywhere else, elements and attributes will be stripped, and only text nodes will be fired (Lookup template="text()" match) 
    -->

    <xsl:template match="*" priority="0.6">       
        <xsl:apply-templates/>
    </xsl:template>   
    
    <!-- in choice apply last child... no element choice is kept. This rule is overruled by more specific choice matches, see below. -->
    <xsl:template match="tei:choice" priority="0.8">        
        <xsl:apply-templates select="node() except *[position()!=last()]"/>
    </xsl:template>
    
    <!-- handling tei_choice @type=s|s_h|s_S1, why is this is a different rule? For norm/dipl differences?-->
    <xsl:template match="tei:choice[@type='s']|tei:choice[@type='s_h']|tei:choice[@type='s_S1']" priority="1.0">
       <xsl:copy>
           <xsl:copy-of select="@*"/>
           <xsl:call-template name="tei_choice_concat"/>
       </xsl:copy>
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
    <xsl:template match="tei:choice[@type='dsl']|tei:choice[@type='dsl_h']|tei:choice[@type='dsl_H1']|tei:choice[@type='dsl_S1']|tei:choice[@type='dsl-em']" priority="1.0">
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
    <xsl:template match="tei:emph[contains(@rend,'blankspace_')]" priority="0.8">
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
    <xsl:template match="tei:seg" priority="0.7">
        <xsl:copy>
        <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Copy seg type notation as is, and apply children-->    
    <xsl:template match="tei:seg[@type='notation']" priority="0.8">
        <xsl:copy>
            <xsl:copy-of select="@type"/>
            <xsl:copy-of select="@corresp"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>  
        
    
    <xsl:template match="tei:persName" priority="1.0">
        <xsl:copy>
            <xsl:copy-of select="@key"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

 <!-- Remove note TAG, Version mar 2018 -->
 <xsl:template match="tei:note" priority="1.0">
    </xsl:template>

    <!-- space handling, logic for adding a space when there is a newline in a space only node-->
    <xsl:template match="text()[matches(self::node(),'\n') and matches(self::node(),'^[&#x09;&#x0A;&#x0D;&#x20;]+$')]" priority="3">       
        <xsl:value-of select="replace(.,'\n',' ')"/>
    </xsl:template> 
    
    <!--mode for secondary transform on input document, to replace multiple spaces with a single space-->
    <!-- copying rule to handle all other matches-->
    <xsl:template match="*" mode="strip-extra-spacing" priority="3.0">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="node()" mode="strip-extra-spacing"/>
        </xsl:copy>
    </xsl:template>   
    
    <!-- text replace-->    
    <xsl:template match="text()" mode="strip-extra-spacing" priority="3.2">
        <xsl:value-of select="replace(.,'\s+',' ','m')"/>       
    </xsl:template>  
    
    <!--END template matches--> 
    
    <!--explicit whitespace handling to remove whitespace on elements with xpath expressions ( to have fine-grained whitespace control-->
   <!-- <xsl:template match="text()[matches(.,'^[&#x09;&#x0A;&#x0D;&#x20;]+$')]
        [parent::tei:corr[@type='trsn']
        or parent::tei:emph[@rend='cap']
        or parent::tei:add[@rend=('im','el')]]" priority="2.0">
        
    </xsl:template>-->
    
    
    
    </xsl:stylesheet>
