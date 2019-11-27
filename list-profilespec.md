---
layout: element
permalink: /profilespec/index.html
element: Profilespecs
---

<table>
<tr>
  <th>Organization</th>
  <th>Pub number</th>
  <th>Title of Profile Specification</th>
</tr>
{% for p in site.profilespec %}
<tr>
  <td><a href="/organization/{{p.orgid}}.html">{{site.data.orgs[p.orgid].short}}</a></td>
  <td>{{p.pubnum}}</td>
  <td><a href="/profilespec/{{p.nisp-id}}.html">{{p.title}}</a></td>
</tr>
{% endfor %}
</table>
