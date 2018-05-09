---
layout: element
permalink: /organization/index.html
element: Organizations
---

Each organisation is postfixed by a tupple with four values, which shows how the organisations creates/owns a number of

1. standards
2. capability profiles
3. profiles
4. service profiles

<ul>
{% for o in site.organization %}
<li><a href="/organization/{{o.key}}.html" title="{{o.long}}">{{o.short}}</a>
({{o.stuff.standards.owns}}, {{o.stuff.capabilityprofiles.owns}},
{{o.stuff.profiles.owns}},
{{o.stuff.serviceprofiles.owns}})</li>
{% endfor%}
</ul>
