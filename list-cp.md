---
layout: element
permalink: /capabilityprofile/index.html
element: Capability Profiles
---

<table>
<tr>
  <th>Organization</th>
  <th>Title of Capability Profiles</th>
</tr>
{% for cp in site.capabilityprofile %}
<tr>
  <td>{{site.data.orgs[cp.profilespec.org].short}}</td>
  <td><a href="/capabilityprofile/{{cp.nisp-id}}.html">{{cp.title}}</a></td>
</tr>
{% endfor %}
</table>
