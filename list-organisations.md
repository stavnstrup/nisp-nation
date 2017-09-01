---
layout: element
permalink: /organisation/index.html
element: Organisations
---

<ul>
{% for o in site.organisation %}
<li><a href="/organisation/{{o.key}}.html">{{o.short}}</a> ({{o.owns}})</li>
{% endfor%}
</ul>
