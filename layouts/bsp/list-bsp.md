---
layout: element
element: Basic Standards Service Profiles
permalink: /bsp/index.html
title: Basic Standards Service Profiles
---

<table>
<tr>
  <th>Basic Standards Service Profiles</th>
</tr>
{% for sp in site.serviceprofile %}
{% if sp.type == 'bsp' %}<tr>
  <td><a href="{{ sp.id }}.html">{{ sp.title }}</a></td>
</tr>{% endif %}
{% endfor %}
</table>
