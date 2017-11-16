---
layout: element
permalink: /profile/index.html
element: Profiles
---

<table>
<tr>
  <th>Organization</th>
  <th>Title of Profiles</th>
  <th>Version</th>
</tr>
{% for p in site.profile %}
<tr>
  <td><a href="/organization/{{sp.profilespec.org}}.html">{{site.data.orgs[p.profilespec.org].short}}</a></td>
  <td><a href="/profile/{{p.nisp-id}}.html">{{p.title}}</a></td>
  <td>{{p.profilespec.version}}</td>
</tr>
{% endfor %}
</table>
