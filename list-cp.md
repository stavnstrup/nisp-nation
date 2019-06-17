---
layout: element
permalink: /capabilityprofile/index.html
element: Capability Profiles
---

A capability profile is an alias for a toplevel profile. You will therefore see these profiles are also listed at the the [profile](/profile/) page.

<table>
<tr>
  <th>Organization</th>
  <th>Title of Capability Profiles</th>
  <th>Version</th>
</tr>
{% for cp in site.capabilityprofile %}
<tr>
  <td><a href="/organization/{{sp.profilespec.org}}.html">{{site.data.orgs[cp.profilespec.org].short}}</a></td>
  <td><a href="/capabilityprofile/{{cp.nisp-id}}.html">{{cp.title}}</a></td>
  <td>{{cp.profilespec.version}}</td>
</tr>
{% endfor %}
</table>
