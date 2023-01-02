---
layout: element
element: Responsible Parties
permalink: /responsibleparty/index.html
---

<ul>
{% for rp in site.responsibleparty %}
<li><a href="/responsibleparty/{{rp.key}}.html" title="{{rp.long}}">{{rp.short}}</a> ({{rp.responsible.number}})</li>
{% endfor%}
</ul>
