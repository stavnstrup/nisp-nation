---
layout: element
element: Basic Standards Service Profiles
permalink: /bsp/index.html
title: Basic Standards Service Profiles
---

<table>
<tr>
  <th>Taxonomy Node</th>
  <th></th>
</tr>
{% for b in site.bsp %}
<tr>
  <td><a href="/bsp/{{ b.node-name }}.html">{{ b.node-title }}</a></td>
  <td></td>
</tr>
{% endfor %}
</table>
