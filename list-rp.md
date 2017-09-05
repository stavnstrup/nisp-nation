---
layout: element
element: Responsible Parties
permalink: /responsibleparty/index.html
---

<ul>
{% for rp in site.responsibleparty %}
<!--
<li><a href="/responsibleparty/{{rp[0]}}.html">{{rp[1].short}}</a></li>
-->
{% if rp.responsible != 0 %}
<li><a href="/responsibleparty/{{rp.key}}.html">{{rp.short}}</a> ({{rp.responsible.number}})</li>
{% endif %}
{% endfor%}
</ul>
