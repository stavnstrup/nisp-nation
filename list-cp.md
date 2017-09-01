---
layout: element
permalink: /capabilityprofile/index.html
element: Capabilityprofiles
---

<ul>
{% for cp in site.capabilityprofile %}
<li><a href="/capabilityprofile/{{cp.nisp-id}}.html">{{site.data.orgs[cp.profilespec.org].short}}: {{cp.title}}</a></li>
{% endfor%}
</ul>
