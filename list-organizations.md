---
layout: element
permalink: /organization/index.html
element: Organizations
---

<ul>
{% for o in site.organization %}
<li><a href="/organization/{{o.key}}.html" title="{{o.text}}">{{o.short}}</a> ({{o.owns}})</li>
{% endfor%}
</ul>
