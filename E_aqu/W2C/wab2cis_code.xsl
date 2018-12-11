<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:m="http://www.w3.org/1998/Math/MathML"
    version="2.0">
    <xsl:output indent="yes" encoding="UTF-8" method="html" />
    
    <xsl:template match="/">
    	<html>
    		<body>
    			<xsl:apply-templates/>
    		</body>
    	</html>
    </xsl:template>
    
    <xsl:template match="title">
        <h1><xsl:apply-templates/></h1>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="s">
    	<p><xsl:value-of select="."/></p>
        <xsl:apply-templates/>
    </xsl:template>
    
</xsl:stylesheet>