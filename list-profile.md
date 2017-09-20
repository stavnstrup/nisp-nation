---
layout: element
permalink: /profile/index.html
element: Profiles
---

<table>
<tr>
  <th>Organisation</th>
  <th>Title of Profile</th>
</tr>
{% for p in site.profile %}
<tr>
  <td>{{site.data.orgs[p.profilespec.org].short}}</td>
  <td><a href="/profile/{{p.nisp-id}}.html">{{p.title}}</a></td>
</tr>
{% endfor %}
</table>
