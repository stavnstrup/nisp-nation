---
layout: element
element: Responsible Parties
permalink: /responsibleparty/index.html
---

<ul>
{% for rp in site.data.rp %}
<li><a href="/responsibleparty/{{rp[0]}}.html">{{rp[1].short}}</a></li>
{% endfor%}
</ul>
