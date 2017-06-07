---
layout: default
permalink: /serviceprofile/index.html
title: Service Profiles
---
<h2>{{ page.title}}</h2>

<ul>
{% for sp in site.serviceprofile %}
<li><a href="/serviceprofile/{{sp.nisp-id}}.html">{{sp.nisp-id}}</a></li>
{% endfor %}
</ul>
