<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                extension-element-prefixes="saxon"
                version='2.0'>

<xsl:output method="text" indent="yes"/>

<xsl:template match="standards">
  <xsl:apply-templates select="records"/>
  <xsl:apply-templates select="organisations"/>
  <xsl:apply-templates select="organisations" mode="data"/>
  <xsl:apply-templates select="responsibleparties"/>
  <xsl:apply-templates select="taxonomy" mode="nodes"/>
  <xsl:apply-templates select="taxonomy"/>
  <xsl:result-document href="_data/stat.json">
    <xsl:text>{</xsl:text>
    <xsl:text>"capabilityprofiles": "</xsl:text><xsl:value-of select="count(records/capabilityprofile)"/><xsl:text>",</xsl:text>
    <xsl:text>"profiles": "</xsl:text><xsl:value-of select="count(records/profile)"/><xsl:text>",</xsl:text>
    <xsl:text>"serviceprofiles": "</xsl:text><xsl:value-of select="count(records/serviceprofile)"/><xsl:text>",</xsl:text>
    <xsl:text>"standards": "</xsl:text><xsl:value-of select="count(records/standard)"/><xsl:text>",</xsl:text>
    <xsl:text>"organizations": "</xsl:text><xsl:value-of select="count(organisations/orgkey)"/><xsl:text>",</xsl:text>
    <xsl:text>"responsibleparties": "</xsl:text><xsl:value-of select="count(responsibleparties/rpkey)"/><xsl:text>",</xsl:text>
    <xsl:text>"nodes": "</xsl:text><xsl:value-of select="count(taxonomy//node)"/><xsl:text>"</xsl:text>
    <xsl:text>}</xsl:text>
  </xsl:result-document>
</xsl:template>

<xsl:template match="taxonomy">
  <xsl:result-document href="_includes/taxonomy.html">
    <xsl:text>&lt;div class="taxonomy"&gt;&#x0A;</xsl:text>
    <xsl:text>&lt;ul&gt;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&lt;/ul&gt;</xsl:text>
    <xsl:text>&lt;/div&gt;&#x0A;</xsl:text>
  </xsl:result-document>
</xsl:template>

<xsl:template match="node">
  <xsl:text>&lt;li&gt;[</xsl:text><xsl:value-of select="@level"/><xsl:text>] </xsl:text>
  <xsl:apply-templates select="@title"/>
  <xsl:if test="./node">
    <xsl:text>&lt;ul&gt;</xsl:text>
    <xsl:apply-templates select="node"/>
    <xsl:text>&lt;/ul&gt;&#x0A;</xsl:text>
  </xsl:if>
  <xsl:text>&lt;/li&gt;&#x0A;</xsl:text>
</xsl:template>


<xsl:template match="taxonomy" mode="nodes">
  <xsl:result-document href="_data/nodes.json">
    <xsl:text>{</xsl:text>
    <xsl:apply-templates mode="nodes"/>
    <xsl:text>"eof-node-tree": {}</xsl:text>
    <xsl:text>}</xsl:text>
  </xsl:result-document>
</xsl:template>

<xsl:template match="node" mode="nodes">
  <xsl:text>"</xsl:text><xsl:value-of select="@id"/><xsl:text>": {</xsl:text>
  <xsl:text>"title": "</xsl:text><xsl:value-of select="@title"/><xsl:text>",</xsl:text>
  <xsl:text>"level": "</xsl:text><xsl:value-of select="@level"/><xsl:text>"},</xsl:text>
  <xsl:apply-templates select="node" mode="nodes"/>
</xsl:template>

<xsl:template match="records">
  <xsl:apply-templates/>
  <xsl:result-document href="_data/events.json">
    <xsl:text>[</xsl:text>
    <xsl:apply-templates select=".//event" mode="allevents">
      <xsl:sort select="@date" order="descending"/>
    </xsl:apply-templates>
    <xsl:text>{"rec": "0", "nisp-id": "", "tag": "", "date": "", "flag": "", "version": "0.0"}</xsl:text>
    <xsl:text>]</xsl:text>
  </xsl:result-document>
</xsl:template>


<xsl:template match="event" mode="allevents">
  <xsl:text>{</xsl:text>
  <xsl:text>"rec": "</xsl:text><xsl:number from="standards" count="standard|serviceprofile|profile|capabilityprofile" format="1" level="any"/><xsl:text>", </xsl:text>
  <xsl:text>"nisp-id": "</xsl:text><xsl:value-of select="../../../@id"/><xsl:text>",</xsl:text>
  <xsl:choose>
    <xsl:when test="ancestor::standard">
      <xsl:text>"tag": "</xsl:text><xsl:value-of select="../../../@tag"/><xsl:text>",</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>"tag": "</xsl:text><xsl:value-of select="../../../@title"/><xsl:text>",</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:text>"date": "</xsl:text><xsl:value-of select="@date"/><xsl:text>",</xsl:text>
  <xsl:text>"flag": "</xsl:text><xsl:value-of select="@flag"/><xsl:text>",</xsl:text>
  <xsl:text>"rfcp": "</xsl:text><xsl:value-of select="@rfcp"/><xsl:text>",</xsl:text>
  <xsl:text>"version": "</xsl:text><xsl:value-of select="@version"/><xsl:text>"</xsl:text>
  <xsl:text>},</xsl:text>
</xsl:template>

<xsl:template match="capabilityprofile">
<xsl:result-document href="_capabilityprofile/{@id}.md">
<xsl:text>---&#x0A;</xsl:text>
<xsl:text>layout: capabilityprofile&#x0A;</xsl:text>
<xsl:text>element: Capabilityprofile&#x0A;</xsl:text>
<xsl:text>nisp-id: </xsl:text><xsl:value-of select="@id"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>title: </xsl:text><xsl:value-of select="@title"/><xsl:text>&#x0A;</xsl:text>
<xsl:apply-templates select="profilespec"/>
<xsl:text>subprofiles:&#x0A;</xsl:text>
<xsl:apply-templates select="subprofiles"/>
<xsl:apply-templates select="status"/>
<xsl:apply-templates select="uuid"/>
<xsl:text>---&#x0A;</xsl:text>
</xsl:result-document>
</xsl:template>


<xsl:template match="profile">
<xsl:result-document href="_profile/{@id}.md">
<xsl:text>---&#x0A;</xsl:text>
<xsl:text>layout: profile&#x0A;</xsl:text>
<xsl:text>element: Profile&#x0A;</xsl:text>
<xsl:text>nisp-id: </xsl:text><xsl:value-of select="@id"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>title: </xsl:text><xsl:value-of select="@title"/><xsl:text>&#x0A;</xsl:text>
<xsl:apply-templates select="profilespec"/>
<xsl:text>subprofiles:&#x0A;</xsl:text>
<xsl:apply-templates select="subprofiles"/>
<xsl:apply-templates select="status"/>
<xsl:apply-templates select="uuid"/>
<xsl:text>---&#x0A;</xsl:text>
</xsl:result-document>
</xsl:template>

<xsl:template match="subprofiles"><xsl:apply-templates/></xsl:template>

<xsl:template match="refprofile">
<xsl:variable name="refid" select="@refid"/>
<xsl:text>  - refid: </xsl:text><xsl:value-of select="@refid"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>    type: </xsl:text><xsl:value-of select="local-name(/standards/records/*[@id=$refid])"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>    title: </xsl:text><xsl:value-of select="/standards/records/*[@id=$refid]/@title"/><xsl:text>&#x0A;</xsl:text>
</xsl:template>

<xsl:template match="serviceprofile">
<xsl:result-document href="_serviceprofile/{@id}.md">
<xsl:text>---&#x0A;</xsl:text>
<xsl:text>layout: serviceprofile&#x0A;</xsl:text>
<xsl:text>element: Serviceprofile&#x0A;</xsl:text>
<xsl:text>nisp-id: </xsl:text><xsl:value-of select="@id"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>title: </xsl:text><xsl:value-of select="@title"/><xsl:text>&#x0A;</xsl:text>
<xsl:apply-templates select="profilespec"/>
<xsl:if test="description">
<xsl:text>description: </xsl:text><xsl:apply-templates select="description"/><xsl:text>&#x0A;</xsl:text>
</xsl:if>
<xsl:text>taxonomy:&#x0A;</xsl:text>
<xsl:apply-templates select="reftaxonomy"/>
<xsl:text>obgroup:&#x0A;</xsl:text>
<xsl:apply-templates select="obgroup"/>
<xsl:apply-templates select="status"/>
<xsl:apply-templates select="uuid"/>
<xsl:text>---&#x0A;</xsl:text>
</xsl:result-document>
</xsl:template>

<xsl:template match="reftaxonomy">
<xsl:text>  - </xsl:text><xsl:value-of select="@refid"/><xsl:text>&#x0A;</xsl:text>
</xsl:template>

<xsl:template match="obgroup">
<xsl:text>  - obligation: </xsl:text><xsl:value-of select="@obligation"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>    standards: </xsl:text><xsl:text>&#x0A;</xsl:text>
<xsl:apply-templates select="refstandard"/>
<xsl:text>    description: </xsl:text><xsl:apply-templates select="description"/><xsl:text>&#x0A;</xsl:text>
</xsl:template>


<xsl:template match="description"><xsl:value-of select="translate(normalize-space(.),':',' ')"/></xsl:template>


<xsl:template match="refstandard">
<xsl:text>    - refid: </xsl:text><xsl:value-of select="@refid"/><xsl:text>&#x0A;</xsl:text>
</xsl:template>

<xsl:template match="standard">
<xsl:if test="not(.//event[(position()=last()) and (@flag='deleted')])">
<xsl:result-document href="_standard/{@id}.md">
<xsl:text>---&#x0A;</xsl:text>
<xsl:text>layout: standard&#x0A;</xsl:text>
<xsl:text>element: Standard&#x0A;</xsl:text>
<xsl:text>nisp-id: </xsl:text><xsl:value-of select="@id"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>tag: "</xsl:text><xsl:value-of select="@tag"/><xsl:text>"&#x0A;</xsl:text>
<xsl:text>orgid: </xsl:text><xsl:value-of select="document/@orgid"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>document:&#x0A;</xsl:text>
<xsl:text>  org: </xsl:text><xsl:value-of select="document/@orgid"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>  pubnum: "</xsl:text><xsl:value-of select="document/@pubnum"/><xsl:text>"&#x0A;</xsl:text>
<xsl:text>  title: "</xsl:text><xsl:value-of select="document/@title"/><xsl:text>"&#x0A;</xsl:text>
<xsl:text>  date: </xsl:text><xsl:value-of select="document/@date"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>applicability: </xsl:text><xsl:apply-templates select="applicability"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>rp: </xsl:text><xsl:value-of select="responsibleparty/@rpref"/><xsl:text>&#x0A;</xsl:text>
<xsl:apply-templates select="status"/>
<xsl:apply-templates select="uuid"/>
<xsl:text>---&#x0A;</xsl:text>
</xsl:result-document>
</xsl:if>
</xsl:template>


<xsl:template match="status">
<xsl:text>status:&#x0A;</xsl:text>
<xsl:text>  uri: </xsl:text><xsl:value-of select="uri"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>  history: &#x0A;</xsl:text>
<xsl:apply-templates select="history/event"/>
</xsl:template>


<xsl:template match="uuid">
<xsl:text>uuid: </xsl:text><xsl:value-of select="."/><xsl:text>&#x0A;</xsl:text>
</xsl:template>


<xsl:template match="event">
<xsl:text>    - flag: </xsl:text><xsl:value-of select="@flag"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>      date: </xsl:text><xsl:value-of select="@date"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>      rfcp: </xsl:text><xsl:value-of select="@rfcp"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>      version: </xsl:text><xsl:value-of select="@version"/><xsl:text>&#x0A;</xsl:text>
</xsl:template>

<xsl:template match="applicability2"><xsl:value-of select="."/></xsl:template>

<xsl:template match="applicability"/>

<xsl:template match="profilespec">
<xsl:text>profilespec:&#x0A;</xsl:text>
<xsl:text>  org: </xsl:text><xsl:value-of select="@orgid"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>  pubnum: </xsl:text><xsl:value-of select="@pubnum"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>  title: </xsl:text><xsl:value-of select="@title"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>  date: </xsl:text><xsl:value-of select="@date"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>  version: </xsl:text><xsl:value-of select="@version"/><xsl:text>&#x0A;</xsl:text>
</xsl:template>


<xsl:template match="organisations" mode="data">
  <xsl:result-document href="_data/orgs.json">
    <xsl:text>{</xsl:text>
    <xsl:apply-templates mode="data"/>
    <xsl:text>}</xsl:text>
  </xsl:result-document>
</xsl:template>

<xsl:template match="orgkey" mode="data">
  <xsl:variable name="mykey" select="@key"/>
  <xsl:text>"</xsl:text><xsl:value-of select="@key"/><xsl:text>": {</xsl:text>
  <xsl:text>"short": "</xsl:text><xsl:value-of select="@short"/><xsl:text>", </xsl:text>
  <xsl:text>"text": "</xsl:text><xsl:value-of select="@text"/><xsl:text>", </xsl:text>
  <xsl:text>"uri": "</xsl:text><xsl:value-of select="@uri"/><xsl:text>", </xsl:text>
  <xsl:text>"owns": "</xsl:text><xsl:value-of
     select="count(/standards//document[@orgid=$mykey])+count(/standards//profilespec[@orgid=$mykey])"/><xsl:text>"}</xsl:text>
  <xsl:if test="not(position()=last())">
    <xsl:text>,</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="organisations">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="orgkey">
<xsl:variable name="mykey" select="@key"/>
<xsl:result-document href="_organization/{@key}.md">
<xsl:text>---&#x0A;</xsl:text>
<xsl:text>layout: organization&#x0A;</xsl:text>
<xsl:text>element: Organizations&#x0A;</xsl:text>
<xsl:text>key: </xsl:text><xsl:value-of select="@key"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>short: </xsl:text><xsl:value-of select="@short"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>text: </xsl:text><xsl:value-of select="@text"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>uri: </xsl:text><xsl:value-of select="@uri"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>owns: </xsl:text><xsl:value-of
       select="count(/standards//document[@orgid=$mykey])+count(/standards//profilespec[@orgid=$mykey])"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>---&#x0A;</xsl:text>
</xsl:result-document>
</xsl:template>

<xsl:template match="responsibleparties">
  <xsl:result-document href="_data/rp.json">
    <xsl:text>{</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:result-document>
</xsl:template>

<xsl:template match="rpkey">
  <xsl:text>"</xsl:text><xsl:value-of select="@key"/><xsl:text>": {</xsl:text>
  <xsl:text>"short": "</xsl:text><xsl:value-of select="@short"/><xsl:text>", </xsl:text>
  <xsl:text>"long": "</xsl:text><xsl:value-of select="@long"/><xsl:text>"}</xsl:text>
  <xsl:if test="not(position()=last())">
    <xsl:text>,</xsl:text>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
