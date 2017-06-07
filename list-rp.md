---
layout: default
permalink: /responsibleparty/index.html
title: Responsible Parties
---
<h2>{{ page.title}}</h2>

<ul>
{% for rp in site.data.rp %}
<li>{{rp[1].short}}</li>
{% endfor%}
</ul>
