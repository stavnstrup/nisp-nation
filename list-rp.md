---
layout: element
element: Responsible Parties
permalink: /responsibleparty/index.html
---

<ul>
{% for rp in site.data.rp %}
<li>{{rp[1].short}}</li>
{% endfor%}
</ul>
