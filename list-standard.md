---
layout: element
element: Standards
permalink: /standard/index.html
---

<p>
<ul class="legendbox">
  <li class="std-complete">Complete</li>
  <li class="std-incomplete">Incomplete</li>
</ul>
</p>

<div class="collection-wrap">

{% assign standard_groups = site.standard | group_by: "orgid" %}
{% for grp in standard_groups %}

<div class="collection-group">

<h4><a href="/organization/{{ grp.name }}.html">{{ site.data.orgs[grp.name].short }}</a></h4>

<ul class="stdgroup">
{% for std in grp.items %}
<li class="collection-item std-{%if std.complete %}complete{% else %}incomplete{% endif %}"><a href="/standard/{{std.nisp-id}}.html" title="{{std.document.title}}">{%   if std.document.pubnum != '' %}{{ std.document.pubnum }}{% else %}{{std.nisp-id}}{% endif %}</a></li>
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
