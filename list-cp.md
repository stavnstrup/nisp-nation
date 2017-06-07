---
layout: default
permalink: /capabilityprofile/index.html
title: Capability Profiles
---
<h2>{{ page.title}}</h2>

<ul>
{% for cp in site.capabilityprofile %}
<li><a href="/capabilityprofile/{{cp.nisp-id}}.html">{{site.data.orgs[cp.profilespec.org].short}}: {{cp.title}}</a></li>
{% endfor%}
</ul>
