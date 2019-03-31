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
  <xsl:apply-templates select="responsibleparties" mode="data"/>
  <xsl:apply-templates select="taxonomy"/>
  <xsl:apply-templates select="taxonomy" mode="taxonomy"/>
  <xsl:apply-templates select="taxonomy" mode="data"/>
  <xsl:result-document href="_data/stat.json">
    <xsl:text>{</xsl:text>
    <xsl:text>"capabilityprofiles": "</xsl:text><xsl:value-of select="count(records/capabilityprofile)"/><xsl:text>",</xsl:text>
    <xsl:text>"profiles": "</xsl:text><xsl:value-of select="count(records/profile)"/><xsl:text>",</xsl:text>
    <xsl:text>"serviceprofiles": "</xsl:text><xsl:value-of select="count(records/serviceprofile)"/><xsl:text>",</xsl:text>
    <xsl:text>"basicstandardsprofile": "1",</xsl:text>
    <xsl:text>"standards": "</xsl:text><xsl:value-of select="count(records/standard)"/><xsl:text>",</xsl:text>
    <xsl:text>"organizations": "</xsl:text><xsl:value-of select="count(organisations/orgkey)"/><xsl:text>",</xsl:text>
    <xsl:text>"responsibleparties": "</xsl:text><xsl:value-of select="count(responsibleparties/rpkey)"/><xsl:text>",</xsl:text>
    <xsl:text>"nodes": "</xsl:text><xsl:value-of select="count(taxonomy//node)"/><xsl:text>"</xsl:text>
    <xsl:text>}</xsl:text>
  </xsl:result-document>
</xsl:template>

<!-- Create a graph illustrating the composite structure of capability profiles -->

<xsl:template match="capabilityprofile" mode="makegraph">
<xsl:result-document href="_includes/graph-{@id}.html" method="html">
<ul class="tree">
  <li class="capability-color"><a href="/capabilityprofile/{@id}.html"><xsl:value-of select="@title"/></a>
  <ul>
    <xsl:for-each select="subprofiles/refprofile">
      <xsl:variable name="thisref" select="@refid"/>
      <xsl:apply-templates select="/standards//profile[@id=$thisref]" mode="makegraph"/>
      <xsl:apply-templates select="/standards//serviceprofile[@id=$thisref]" mode="makegraph"/>
    </xsl:for-each>
  </ul>
  </li>
</ul>
</xsl:result-document>
</xsl:template>

<xsl:template match="profile" mode="makegraph">
  <li class="profile-color"><a href="/profile/{@id}.html"><xsl:value-of select="@title"/></a>
    <ul>
      <xsl:for-each select="subprofiles/refprofile">
        <xsl:variable name="thisref" select="@refid"/>
        <xsl:apply-templates select="/standards//profile[@id=$thisref]" mode="makegraph"/>
        <xsl:apply-templates select="/standards//serviceprofile[@id=$thisref]" mode="makegraph"/>
      </xsl:for-each>
    </ul>
  </li>
</xsl:template>

<xsl:template match="serviceprofile" mode="makegraph">
  <li class="service-color"><a href="/serviceprofile/{@id}.html"><xsl:value-of select="@title"/></a></li>
</xsl:template>

<!-- Create a page illustrating the composite structure of capability profiles -->

<xsl:template match="capabilityprofile" mode="makepage">
<xsl:result-document href="_includes/page-{@id}.html" method="html">
  <h2><xsl:value-of select="@title"/></h2>
  <xsl:for-each select="subprofiles/refprofile">
    <xsl:variable name="thisref" select="@refid"/>
    <xsl:apply-templates select="/standards//profile[@id=$thisref]" mode="makepage"/>
    <xsl:apply-templates select="/standards//serviceprofile[@id=$thisref]" mode="makepage"/>
  </xsl:for-each>
</xsl:result-document>
</xsl:template>

<xsl:template match="profile" mode="makepage">
  <h3><xsl:value-of select="@title"/></h3>

  <!-- Identify type of the element referenced from the first refprofile element -->
  <xsl:variable name="firstrefid" select="subprofiles/refprofile[1]/@refid"/>
  <xsl:variable name="elementname" select="name(/standards//profile[@id=$firstrefid])"/>

  <xsl:choose>
    <xsl:when test="$elementname= 'profile'">
      <xsl:for-each select="subprofiles/refprofile">
        <xsl:variable name="thisref" select="@refid"/>
        <xsl:apply-templates select="/standards//profile[@id=$thisref]" mode="makepage"/>
     </xsl:for-each>
    </xsl:when>
    <xsl:otherwise>
      <table>
        <colgroup>
          <col style="width: 18%;"/>
          <col style="width: 44%;"/>
          <col style="width: 38%;"/>
        </colgroup>
        <thead>
          <tr>
            <th>Service</th>
            <th>Standard</th>
            <th>Implementation Guidance</th>
          </tr>
        </thead>
        <tbody>
        <xsl:for-each select="subprofiles/refprofile">
          <xsl:variable name="thisref" select="@refid"/>
          <xsl:apply-templates select="/standards//serviceprofile[@id=$thisref]" mode="makepage"/>
        </xsl:for-each>
        </tbody>
      </table>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="serviceprofile" mode="makepage">
  <tr>
    <td colspan="3"><p><strong><xsl:value-of select="@title"/></strong></p>
     <p><xsl:value-of select="description"/></p>
    </td>
  </tr>
  <tr>
    <td>
      <xsl:if test="not(count(reftaxonomy))">
        <xsl:text>UNKNOWN SERVICE</xsl:text>
      </xsl:if>
      <xsl:apply-templates select="reftaxonomy" mode="makepage"/>
    </td>
    <td><xsl:apply-templates select="refgroup" mode="makepage"/></td>
    <td><xsl:apply-templates select="guide" mode="makepage"/></td>
  </tr>
</xsl:template>

<xsl:template match="reftaxonomy" mode="makepage">
  <xsl:variable name="myrefid" select="@refid"/>
  <p>
    <xsl:value-of select="/standards//node[@id=$myrefid]/@title"/>
    <xsl:if test="following-sibling::reftaxonomy">
      <xsl:text>, </xsl:text>
    </xsl:if>
  </p>
</xsl:template>

<xsl:template match="refgroup"  mode="makepage">
  <p><em>
    <xsl:choose>
      <xsl:when test="@obligation='mandatory'">Mandatory</xsl:when>
      <xsl:when test="@obligation='recommended'">Recommended</xsl:when>
      <xsl:when test="@obligation='optional'">Optional</xsl:when>
      <xsl:when test="@obligation='conditional'">Conditional</xsl:when>
      <xsl:otherwise>ERROR</xsl:otherwise>
    </xsl:choose>
  </em></p>
  <xsl:if test="./description">
    <p><xsl:value-of select="./description"/></p>
  </xsl:if>
  <ul spacing="compact">
    <xsl:apply-templates select="refstandard" mode="makepage"/>
  </ul>
</xsl:template>


<xsl:template match="refstandard"  mode="makepage">
  <xsl:variable name="myrefid" select="@refid"/>
  <li><xsl:apply-templates select="/standards//standard[@id=$myrefid]"  mode="makepage"/></li>
</xsl:template>


<xsl:template match="standard" mode="makepage">
  <xsl:variable name="myorg" select="document/@orgid"/>
  <xsl:variable name="orgname" select="ancestor::standards/organisations/orgkey[@key=$myorg]/@short"/>
  <xsl:if test="$orgname">
    <xsl:value-of select="$orgname"/>
    <xsl:text> </xsl:text>
  </xsl:if>
  <xsl:value-of select="document/@pubnum"/>
  <xsl:text> - </xsl:text>
  <xsl:value-of select="document/@title"/>
</xsl:template>


<xsl:template match="guide" mode="makepage">
  <p><xsl:apply-templates mode="makepage"/></p>
</xsl:template>


<xsl:template match="itemizedlist|orderedlist" mode="makepage">
<ul><xsl:apply-templates mode="makepage"/></ul>
</xsl:template>


<xsl:template match="listitem" mode="makepage">
<li><xsl:apply-templates mode="makepage"/></li>
</xsl:template>

<xsl:template match="listitem/para" mode="makepage"><xsl:apply-templates mode="makepage"/></xsl:template>


<xsl:template match="para" mode="makepage"><xsl:apply-templates mode="makepage"/></xsl:template>


<xsl:template match="text()" mode="makepage">
<xsl:variable name="escapeChars" select="'\&quot;'"/>
<xsl:if test="name(..)='applicability'"> </xsl:if>
<xsl:value-of select="translate(translate(normalize-space(),':',' '), $escapeChars, ' ')"/>
</xsl:template>


<!-- Process all standards and profiles -->

<xsl:template match="records">
  <xsl:apply-templates select="capabilityprofile" mode="makegraph"/>
  <xsl:apply-templates select="capabilityprofile" mode="makepage"/>
  <!-- Process all standard and profiles -->
  <xsl:apply-templates/>
  <!-- List all events in descending order in all standards and profiles -->
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

<!-- Create a YAML page of a Capability Profile -->

<xsl:template match="capabilityprofile[@type='bsp']"/>

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

<!-- Create a YAML page of a Profile -->

<xsl:template match="profile">
<xsl:variable name="myid" select="@id"/>
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
<xsl:text>parents:&#x0A;</xsl:text>
<xsl:apply-templates select="/standards//refprofile[@refid=$myid]" mode="listparent"/>
<xsl:text>---&#x0A;</xsl:text>
</xsl:result-document>
</xsl:template>


<xsl:template match="subprofiles"><xsl:apply-templates/></xsl:template>

<xsl:template match="refprofile" mode="listparent">
<xsl:text>  - refid: </xsl:text><xsl:value-of select="../../@id"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>    type: </xsl:text><xsl:value-of select="local-name(../..)"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>    title: </xsl:text><xsl:value-of select="../../@title"/><xsl:text>&#x0A;</xsl:text>
</xsl:template>


<xsl:template match="refprofile">
<xsl:variable name="refid" select="@refid"/>
<xsl:text>  - refid: </xsl:text><xsl:value-of select="@refid"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>    type: </xsl:text><xsl:value-of select="local-name(/standards/records/*[@id=$refid])"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>    title: </xsl:text><xsl:value-of select="/standards/records/*[@id=$refid]/@title"/><xsl:text>&#x0A;</xsl:text>
</xsl:template>

<!-- Create a YAML page of a Service  Profile -->

<xsl:template match="serviceprofile1[@type='bsp']"/>

<xsl:template match="serviceprofile">
<xsl:variable name="myid" select="@id"/>
<xsl:result-document href="_serviceprofile/{@id}.md">
<xsl:text>---&#x0A;</xsl:text>
<xsl:text>layout: serviceprofile&#x0A;</xsl:text>
<xsl:text>element: Serviceprofile&#x0A;</xsl:text>
<xsl:text>nisp-id: </xsl:text><xsl:value-of select="@id"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>type: </xsl:text><xsl:value-of select="@type"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>title: </xsl:text><xsl:value-of select="@title"/><xsl:text>&#x0A;</xsl:text>
<xsl:apply-templates select="profilespec"/>
<xsl:if test="description">
<xsl:text>description: </xsl:text><xsl:apply-templates select="description"/><xsl:text>&#x0A;</xsl:text>
</xsl:if>
<xsl:text>taxonomy:&#x0A;</xsl:text>
<xsl:apply-templates select="reftaxonomy"/>
<xsl:text>refgroup:&#x0A;</xsl:text>
<xsl:apply-templates select="refgroup"/>
<xsl:apply-templates select="status"/>
<xsl:apply-templates select="uuid"/>
<xsl:text>parents:&#x0A;</xsl:text>
<xsl:apply-templates select="/standards//refprofile[@refid=$myid]" mode="listparent"/>
<xsl:text>---&#x0A;</xsl:text>
</xsl:result-document>
</xsl:template>


<xsl:template match="reftaxonomy">
<xsl:text>  - </xsl:text><xsl:value-of select="@refid"/><xsl:text>&#x0A;</xsl:text>
</xsl:template>


<xsl:template match="refgroup">
<xsl:text>  - obligation: </xsl:text><xsl:value-of select="@obligation"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>    lifecycle: </xsl:text><xsl:value-of select="@lifecycle"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>    standards: </xsl:text><xsl:text>&#x0A;</xsl:text>
<xsl:apply-templates select="refstandard"/>
<xsl:text>    description: </xsl:text><xsl:apply-templates select="description"/><xsl:text>&#x0A;</xsl:text>
</xsl:template>


<xsl:template match="description"><xsl:value-of select="translate(normalize-space(.),':',' ')"/></xsl:template>

<xsl:template match="refstandard">
<xsl:text>    - refid: </xsl:text><xsl:value-of select="@refid"/><xsl:text>&#x0A;</xsl:text>
</xsl:template>


<!-- Create Standards -->

<xsl:template match="standard">
<xsl:variable name="myid" select="@id"/>
<xsl:if test="not(.//event[(position()=last()) and (@flag='deleted')])">
<xsl:result-document href="_standard/{@id}.md">
<xsl:text>---&#x0A;</xsl:text>
<xsl:text>layout: standard&#x0A;</xsl:text>
<xsl:text>element: Standard&#x0A;</xsl:text>
<xsl:text>complete: </xsl:text><xsl:value-of select="(document/@orgid != '') and
  (document/@pubnum != '') and (document/@title != '') and (document/@date != '')"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>nisp-id: </xsl:text><xsl:value-of select="@id"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>tag: "</xsl:text><xsl:value-of select="@tag"/><xsl:text>"&#x0A;</xsl:text>
<xsl:text>orgid: </xsl:text><xsl:value-of select="document/@orgid"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>document:&#x0A;</xsl:text>
<xsl:text>  org: </xsl:text><xsl:value-of select="document/@orgid"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>  pubnum: "</xsl:text><xsl:value-of select="document/@pubnum"/><xsl:text>"&#x0A;</xsl:text>
<xsl:text>  title: "</xsl:text><xsl:value-of select="normalize-space(document/@title)"/><xsl:text>"&#x0A;</xsl:text>
<xsl:text>  date: </xsl:text><xsl:value-of select="document/@date"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>  version: "</xsl:text><xsl:value-of select="document/@version"/><xsl:text>"&#x0A;</xsl:text>
<xsl:text>applicability:</xsl:text><xsl:apply-templates select="applicability"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>rp: </xsl:text><xsl:value-of select="responsibleparty/@rpref"/><xsl:text>&#x0A;</xsl:text>
<xsl:apply-templates select="status"/>
<xsl:apply-templates select="uuid"/>
<xsl:text>consumers:&#x0A;</xsl:text>
<xsl:apply-templates select="/*//serviceprofile/refgroup/refstandard[@refid=$myid]" mode="sp-to-sd"/>
<xsl:text>---&#x0A;</xsl:text>
</xsl:result-document>
</xsl:if>
</xsl:template>

<xsl:template match="refstandard" mode="sp-to-sd">
<xsl:text>  - </xsl:text><xsl:value-of select="../../@id"/><xsl:text>&#x0A;</xsl:text>
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

<xsl:template match="applicability">
<xsl:if test="count(./node()) &gt; 0">
<xsl:text> >2&#x0A;</xsl:text>
<xsl:apply-templates/>
</xsl:if>
</xsl:template>


<xsl:template match="itemizedlist|orderedlist">
<xsl:text>&#x0A;&#x0A;</xsl:text>
<xsl:apply-templates/>
</xsl:template>


<xsl:template match="listitem">
<xsl:text>  *</xsl:text><xsl:apply-templates/><xsl:text>&#x0A;&#x0A;</xsl:text>
</xsl:template>

<xsl:template match="listitem/para"><xsl:text>  </xsl:text><xsl:apply-templates/></xsl:template>


<xsl:template match="para"><xsl:text>  </xsl:text><xsl:apply-templates/><xsl:text>&#x0A;&#x0A;</xsl:text></xsl:template>


<xsl:template match="text()">
<xsl:variable name="escapeChars" select="'\&quot;'"/>
<xsl:if test="name(..)='applicability'"><xsl:text>  </xsl:text></xsl:if>
<xsl:value-of select="translate(translate(normalize-space(),':',' '), $escapeChars, ' ')"/>
</xsl:template>


<xsl:template match="profilespec">
<xsl:text>profilespec:&#x0A;</xsl:text>
<xsl:text>  org: </xsl:text><xsl:value-of select="@orgid"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>  pubnum: </xsl:text><xsl:value-of select="@pubnum"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>  title: </xsl:text><xsl:value-of select="@title"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>  date: </xsl:text><xsl:value-of select="@date"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>  version: </xsl:text><xsl:value-of select="@version"/><xsl:text>&#x0A;</xsl:text>
</xsl:template>

<!-- Create a YAML page for each organisation -->

<xsl:template match="organisations">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="orgkey">
<xsl:variable name="mykey" select="@key"/>
<xsl:result-document href="_organization/{@key}.md">
<xsl:text>---&#x0A;</xsl:text>
<xsl:text>layout: organization&#x0A;</xsl:text>
<xsl:text>element: Organizations&#x0A;</xsl:text>
<xsl:text>nisp-id: </xsl:text><xsl:value-of select="@key"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>key: </xsl:text><xsl:value-of select="@key"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>short: </xsl:text><xsl:value-of select="@short"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>long: </xsl:text><xsl:value-of select="@long"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>uri: </xsl:text><xsl:value-of select="@uri"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>stuff:&#x0A;</xsl:text>
<xsl:text>  standards:&#x0A;</xsl:text>
<xsl:text>    owns: </xsl:text><xsl:value-of
       select="count(/standards//document[@orgid=$mykey])"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>    references:&#x0A;</xsl:text>
<xsl:apply-templates select="/*//standard/document[@orgid=$mykey]" mode="liststandard"/>
<xsl:text>  capabilityprofiles:&#x0A;</xsl:text>
<xsl:text>    owns: </xsl:text><xsl:value-of
       select="count(/standards//capabilityprofile/profilespec[@orgid=$mykey])"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>    references:&#x0A;</xsl:text>
<xsl:apply-templates select="/*//capabilityprofile/profilespec[@orgid=$mykey]" mode="listprofile"/>
<xsl:text>  profiles:&#x0A;</xsl:text>
<xsl:text>    owns: </xsl:text><xsl:value-of
       select="count(/standards//profile/profilespec[@orgid=$mykey])"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>    references:&#x0A;</xsl:text>
<xsl:apply-templates select="/*//profile/profilespec[@orgid=$mykey]" mode="listprofile"/>
<xsl:text>  serviceprofiles:&#x0A;</xsl:text>
<xsl:text>    owns: </xsl:text><xsl:value-of
       select="count(/standards//serviceprofile/profilespec[@orgid=$mykey])"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>    references:&#x0A;</xsl:text>
<xsl:apply-templates select="/*//serviceprofile/profilespec[@orgid=$mykey]" mode="listprofile"/>
<xsl:text>---&#x0A;</xsl:text>
</xsl:result-document>
</xsl:template>

<xsl:template match="document" mode="liststandard">
<xsl:text>    - </xsl:text><xsl:value-of select="../@id"/><xsl:text>&#x0A;</xsl:text>
</xsl:template>

<xsl:template match="profilespec" mode="listprofile">
<xsl:text>    - </xsl:text><xsl:value-of select="../@id"/><xsl:text>&#x0A;</xsl:text>
</xsl:template>

<!-- Create JSON file with all organisations -->

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
  <xsl:text>"long": "</xsl:text><xsl:value-of select="@long"/><xsl:text>", </xsl:text>
  <xsl:text>"uri": "</xsl:text><xsl:value-of select="@uri"/><xsl:text>", </xsl:text>
  <xsl:text>"owns": "</xsl:text><xsl:value-of
     select="count(/standards//document[@orgid=$mykey])+count(/standards//profilespec[@orgid=$mykey])"/><xsl:text>"}</xsl:text>
  <xsl:if test="not(position()=last())">
    <xsl:text>,</xsl:text>
  </xsl:if>
</xsl:template>

<!-- Create a YAML page for each responsible party -->

<xsl:template match="responsibleparties">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="rpkey">
<xsl:variable name="mykey" select="@key"/>
<xsl:if test="count(/standards//standard[responsibleparty/@rpref=$mykey]) > 0">
<xsl:result-document href="_responsibleparty/{@key}.md">
<xsl:text>---&#x0A;</xsl:text>
<xsl:text>layout: responsibleparty&#x0A;</xsl:text>
<xsl:text>element: Responsible Party&#x0A;</xsl:text>
<xsl:text>nisp-id: </xsl:text><xsl:value-of select="@key"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>key: </xsl:text><xsl:value-of select="@key"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>short: </xsl:text><xsl:value-of select="@short"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>long: </xsl:text><xsl:value-of select="@long"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>responsible:&#x0A;</xsl:text>
<xsl:text>  number: </xsl:text><xsl:value-of select="count(/standards//standard[responsibleparty/@rpref=$mykey])"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>  standards:&#x0A;</xsl:text>
<xsl:apply-templates select="/*//standard/responsibleparty[@rpref=$mykey]" mode="liststandard"/>
<xsl:text>---&#x0A;</xsl:text>
</xsl:result-document>
</xsl:if>
</xsl:template>

<xsl:template match="responsibleparty" mode="liststandard">
<xsl:text>    - </xsl:text><xsl:value-of select="../@id"/><xsl:text>&#x0A;</xsl:text>
</xsl:template>

<!-- Create JSON file listing all responsible parties -->

<xsl:template match="responsibleparties" mode="data">
  <xsl:result-document href="_data/rp.json">
    <xsl:text>{</xsl:text>
    <xsl:apply-templates mode="data"/>
    <xsl:text>}</xsl:text>
  </xsl:result-document>
</xsl:template>

<xsl:template match="rpkey" mode="data">
  <xsl:text>"</xsl:text><xsl:value-of select="@key"/><xsl:text>": {</xsl:text>
  <xsl:text>"short": "</xsl:text><xsl:value-of select="@short"/><xsl:text>", </xsl:text>
  <xsl:text>"long": "</xsl:text><xsl:value-of select="@long"/><xsl:text>"}</xsl:text>
  <xsl:if test="not(position()=last())">
    <xsl:text>,</xsl:text>
  </xsl:if>
</xsl:template>

<!-- Create a YAML page for each taxaonomy node -->

<xsl:template match="taxonomy">
  <xsl:apply-templates select="node">
    <xsl:with-param name="parent" select="'null'"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="node">
<xsl:param name="parent"/>
<xsl:variable name="myid" select="@id"/>
<xsl:result-document href="_node/{@id}.md">
<xsl:text>---&#x0A;</xsl:text>
<xsl:text>layout: node&#x0A;</xsl:text>
<xsl:text>element: node&#x0A;</xsl:text>
<xsl:text>nisp-id: </xsl:text><xsl:value-of select="@id"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>parent: </xsl:text><xsl:value-of select="$parent"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>title: </xsl:text><xsl:value-of select="@title"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>description: </xsl:text><xsl:value-of select="translate(normalize-space(@description),':',' ')"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>level: </xsl:text><xsl:value-of select="@level"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>emUUID: </xsl:text><xsl:value-of select="@emUUID"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>usage:&#x0A;</xsl:text>
<xsl:if test="count(//bprefstandard[(../../@tref=$myid) and (../@mode='mandatory')]) > 0">
<xsl:text>  mandatory:&#x0A;</xsl:text>
<xsl:apply-templates select="//bprefstandard[(../@mode='mandatory') and (../../@tref=$myid)]" mode="listbpstandards"/>
</xsl:if>
<xsl:if test="count(//bprefstandard[(../../@tref=$myid) and (../@mode='candidate')]) > 0">
<xsl:text>  candidate:&#x0A;</xsl:text>
<xsl:apply-templates select="//bprefstandard[(../@mode='candidate') and (../../@tref=$myid)]" mode="listbpstandards"/>
</xsl:if>
<xsl:text>  serviceprofiles:&#x0A;</xsl:text>
<xsl:apply-templates select="//reftaxonomy[@refid=$myid]" mode="nodeserviceprofiles"/>
<xsl:text>---&#x0A;</xsl:text>
</xsl:result-document>
<xsl:apply-templates select="node">
  <xsl:with-param name="parent" select="@id"/>
</xsl:apply-templates>
</xsl:template>

<xsl:template match="bprefstandard" mode="listbpstandards">
  <xsl:text>    - refid: </xsl:text><xsl:value-of select="@refid"/><xsl:text>&#x0A;</xsl:text>
</xsl:template>

<xsl:template match="reftaxonomy[../name()='serviceprofile']" mode="nodeserviceprofiles">
<xsl:text>    - spid: </xsl:text><xsl:value-of select="../@id"/><xsl:text>&#x0A;</xsl:text>
<xsl:text>      standards:&#x0A;</xsl:text>
<xsl:for-each select="../refgroup[@obligation='mandatory']/refstandard">
<xsl:text>        - refid: </xsl:text><xsl:value-of select="@refid"/><xsl:text>&#x0A;</xsl:text>
</xsl:for-each>
</xsl:template>

<!-- Create Taxonomy Tree -->

<xsl:template match="taxonomy" mode="taxonomy">
  <xsl:result-document href="_includes/taxonomy.html" method="html">
    <div class="taxonomy">
      <ul>
        <xsl:apply-templates mode="taxonomy"/>
      </ul>
    </div>
  </xsl:result-document>
</xsl:template>


<xsl:template match="node" mode="taxonomy">
  <li>[<xsl:value-of select="@level"/><xsl:text>] </xsl:text>
  <a>
    <xsl:attribute name="href">
      <xsl:text>/node/</xsl:text>
      <xsl:value-of select="@id"/>
      <xsl:text>.html</xsl:text>
    </xsl:attribute>
    <xsl:apply-templates select="@title"/>
  </a>
  <xsl:apply-templates select="." mode="count-stuff"/>
  <xsl:if test="./node">
    <ul>
      <xsl:apply-templates select="node" mode="taxonomy"/>
    </ul>
  </xsl:if>
  </li>
</xsl:template>

<xsl:template match="node" mode="count-stuff">
  <xsl:variable name="myid" select="@id"/>
  <xsl:variable name="mandatory" select="count(//bprefstandard[(../../@tref=$myid) and (../@mode='mandatory')])"/>
  <xsl:variable name="candidate" select="count(//bprefstandard[(../../@tref=$myid) and (../@mode='candidate')])"/>
  <xsl:variable name="services" select="count(//reftaxonomy[@refid=$myid])"/>
  <xsl:if test="$mandatory+$candidate+$services &gt; 0">
    <xsl:text> (</xsl:text>
    <xsl:value-of select="$mandatory"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$candidate"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$services"/>
    <xsl:text>)</xsl:text>
  </xsl:if>
</xsl:template>

<!-- Create JSON representation of the taxonomy -->

<xsl:template match="taxonomy" mode="data">
  <xsl:result-document href="_data/nodes.json">
    <xsl:text>{</xsl:text>
    <xsl:apply-templates mode="data"/>
    <xsl:text>"eof-node-tree": {}</xsl:text>
    <xsl:text>}</xsl:text>
  </xsl:result-document>
</xsl:template>


<xsl:template match="node" mode="data">
  <xsl:text>"</xsl:text><xsl:value-of select="@id"/><xsl:text>": {</xsl:text>
  <xsl:text>"title": "</xsl:text><xsl:value-of select="@title"/><xsl:text>",</xsl:text>
  <xsl:text>"level": "</xsl:text><xsl:value-of select="@level"/><xsl:text>"},</xsl:text>
  <xsl:apply-templates select="node" mode="data"/>
</xsl:template>


</xsl:stylesheet>
