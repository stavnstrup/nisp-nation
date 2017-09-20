---
layout: element
element: Service Profiles
permalink: /serviceprofile/index.html
title: Service Profiles
---

<table>
<tr>
  <th>Organisation</th>
  <th>Title of Service Profile</th>
</tr>
{% for sp in site.serviceprofile %}
<tr>
  <td>{{site.data.orgs[sp.profilespec.org].short}}</td>
  <td><a href="/serviceprofile/{{sp.nisp-id}}.html">{{sp.title}}</a></td>
</tr>
{% endfor %}
</table>
