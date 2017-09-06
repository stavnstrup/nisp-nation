---
layout: element
permalink: /organization/index.html
element: Organizations
---

<ul>
{% for o in site.organization %}
<li><a href="/organization/{{o.key}}.html" title="{{o.text}}">{{o.short}}</a>
({{o.stuff.standards.owns}}, {{o.stuff.capabilityprofiles.owns}},
{{o.stuff.profiles.owns}},
{{o.stuff.serviceprofiles.owns}})</li>
{% endfor%}
</ul>
