---
layout: element
element: Serviceprofiles
permalink: /serviceprofile/index.html
title: Service Profiles
---

<ul>
{% for sp in site.serviceprofile %}
<li><a href="/serviceprofile/{{sp.nisp-id}}.html">{{site.data.orgs[sp.profilespec.org].short}}: {{sp.title}}</a></li>
{% endfor %}
</ul>
