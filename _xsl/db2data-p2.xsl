<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                extension-element-prefixes="saxon"
                version='2.0'>


<xsl:output saxon:next-in-chain="db2data-p3.xsl"/>


<xsl:template match="orgkey">
  <xsl:variable name="mykey" select="@key"/>
  <xsl:if test="(count(/standards//document[@orgid=$mykey])+count(/standards//profilespec[@orgid=$mykey]))>0">
    <orgkey>
      <xsl:apply-templates select="@*"/>
    </orgkey>
  </xsl:if>
</xsl:template>

<xsl:template match="node">
  <xsl:variable name="myid" select="@id"/>
  <node>
    <xsl:apply-templates select="@*"/>
    <xsl:apply-templates/>
    <!-- Which standards in the best practiceprofile is referencing this node -->
    <xsl:apply-templates select="/standards/bestpracticeprofile//bprefstandard[ancestor::bpserviceprofile/@tref=$myid]"/>
    <!-- Which standards in a serviceprofile is referencing this node -->
    <xsl:apply-templates select="/standards//refstandard[ancestor::serviceprofile/reftaxonomy/@refid=$myid]"/>
  </node>
</xsl:template>


<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*"/>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>


</xsl:stylesheet>