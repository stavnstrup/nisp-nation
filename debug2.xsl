<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                extension-element-prefixes="saxon"
                version='2.0'>


<xsl:output saxon:next-in-chain="deb-mkJSON.xsl"/>

<xsl:template match="orgkey">
  <xsl:variable name="mykey" select="@key"/>
  <xsl:if test="(count(/standards//document[@orgid=$mykey])+count(/standards//profilespec[@orgid=$mykey]))>0">
    <orgkey>
      <xsl:apply-templates select="@*"/>
    </orgkey>
  </xsl:if>
</xsl:template>

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*"/>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>


</xsl:stylesheet>
