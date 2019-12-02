---
layout: element
permalink: /coverdoc/index.html
element: Cover Documents
---


<table>
<tr>
  <th>Pubnum</th>
  <th>Title</th>
  <th>Date</th>
</tr>
{% for p in site.coverdoc %}
<tr>
  <td>{{p.document.pubnum}}</td>
  <td><a href="/coverdoc/{{p.nisp-id}}.html">{{p.document.title}}</a></td>
  <td>{{p.document.date | slice: 0,4}}</td>
</tr>
{% endfor %}
</table>
