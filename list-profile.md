---
layout: element
permalink: /profile/index.html
element: Profiles
---

<ul>
{% for p in site.profile %}
<li><a href="/profile/{{p.nisp-id}}.html">{{site.data.orgs[p.profilespec.org].short}}: {{p.title}}</a></li>
{% endfor %}
</ul>
