---
layout: element
element: Service Profiles
permalink: /serviceprofile/index.html
title: Service Profiles
---

<table>
<tr>
  <th>Organization</th>
  <th>Title of Service Profiles</th>
  <th>Version</th>
</tr>
{% for sp in site.serviceprofile %}
<tr>
  <td><a href="/organization/{{sp.profilespec.org}}.html">{{site.data.orgs[sp.profilespec.org].short}}</a></td>
  <td><a href="/serviceprofile/{{sp.nisp-id}}.html">{{sp.title}}</a></td>
  <td>{{sp.profilespec.version}}</td>
</tr>
{% endfor %}
</table>
