---
layout: element
element: Standards
permalink: /standard/index.html
pagetype: Standards
---

<div class="collection-wrap">


{% assign standard_groups = (site.standard | group_by: "orgid") %}

{% for grp in standard_groups %}


<div class="collection-group">

<h4><a href="/organisation/{{ grp.name }}.html">{{ site.data.orgs[grp.name].short }}</a></h4>

<ul>
{% for std in grp.items %}

<li><a href="/standard/{{std.nisp-id}}.html" title="{{std.document.title}}">{% if std.document.pubnum != '' %}{{ std.document.pubnum }}{% else %}{{std.nisp-id}}{% endif %}</a></li>

{% capture mod %}{{ forloop.index | modulo:10 }}{% endcapture %}
{% if  mod == '0' %}    
</ul>
</div>
<div  class="collection-group">
<ul>
{% endif %}

{% endfor %}
</ul>
</div>

{% endfor %}

</div>
