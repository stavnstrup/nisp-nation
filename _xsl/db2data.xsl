<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                extension-element-prefixes="saxon"
                version='2.0'>


<xsl:output saxon:next-in-chain="db2data-p2.xsl"/>

<xsl:template match="*[status/@mode='deleted']"/>

<!-- ==================================================================== -->

<!-- Add type attribute to all service profile, to be able to differentiate serviceprofiles,
     which are part of the Base Standards Profile and those which are not -->

<xsl:template match="serviceprofile">
  <xsl:variable name="myid" select="@id"/>
  <serviceprofile>
    <xsl:attribute name="type">
      <xsl:choose>
        <xsl:when test="/standards//capabilityprofile[@id='bsp']//refprofile[@refid=$myid]">
          <xsl:text>bsp</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>coi</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:apply-templates select="@*"/>
    <xsl:apply-templates/>
  </serviceprofile>
</xsl:template>

<xsl:template match="standards">
  <standards>
    <xsl:apply-templates/>
    <responsibleparties>
      <xsl:apply-templates select="organisations/orgkey" mode="mirror"/>
    </responsibleparties>
  </standards>
</xsl:template>

<xsl:template match="orgkey" mode="mirror">
  <rpkey key="{@key}" short="{@short}" long="{@long}"/>
</xsl:template>

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*"/>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>
