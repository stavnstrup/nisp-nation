---
layout: default
permalink: /organisation/index.html
title: Organisations
---
<h2>{{ page.title}}</h2>


<ul>
{% for o in site.data.organisations %}
<li>{{o[1].short}} ({{o[1].owns}})</li>
{% endfor%}
</ul>
