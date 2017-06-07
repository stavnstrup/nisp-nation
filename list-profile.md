---
layout: default
permalink: /profile/index.html
title: Profiles
---
<h2>{{ page.title}}</h2>

<ul>
{% for p in site.profile %}
<li><a href="/profile/{{p.nisp-id}}.html">{{site.data.orgs[p.profilespec.org].short}}: {{p.title}}</a></li>
{% endfor %}
</ul>
