---
layout: default
permalink: /organisation/index.html
title: Organisations
---
<h2>{{ page.title}}</h2>


<ul>
{% for o in site.organisation %}
<li><a href="/organisation/{{o.key}}.html">{{o.short}}</a> ({{o.owns}})</li>
{% endfor%}
</ul>
