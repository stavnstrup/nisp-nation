---
layout: default
permalink: /standard/index.html
title: Standards
---

<h2>{{ page.title }}</h2>

<div class="collection-wrap">


{% assign s_groups = (site.standard | group_by: "orgid") %}

{% for g in s_groups %}

<div class="collection-group">
<h4>{{ g.name }}</h4>

<ul>
{% for std in g.items %}

<li><a href="/standard/{{std.nisp-id}}.html">{{std.nisp-id}}</a></li>

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
