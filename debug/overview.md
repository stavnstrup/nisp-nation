---
layout: default
---

<h2>Overview</h2>

<table border="1">
<tr class="head">
  <th>Rec</th>
  <th>ID</th>
  <th>Type</th>
  <th>Org</th>
  <th>PubNum</th>
  <th>Title</th>
  <th>Date</th>
  <th>Ver</th>
  <th>Responsible Party</th>
  <th>Tag</th>
  <th>Best Practice</th>
  <th>History</th>
  <th>URI</th>
 </tr>

{% for std in site.standard %}
  <tr>
    <td>{{forloop.index}}</td>
    <td>{{ std.nisp-id }}</td>
    <td></td>
    <td>{{ site.data.organisations[std.document.org]['short'] }}</td>
    <td>{{ std.document.pubnum }}</td>
    <td>{{ std.document.title }}</td>
    <td>{{ std.document.date }}</td>
    <td>{{ std.document.ver }}</td>
    <td>{{ site.data.rp[std.rp]['short'] }}</td>
    <td>{{ std.tag }}</td>
    <td>BP</td>
    <td>HISTORY</td>
    <td><a href="{{ std.status.uri }}">{{ std.status.uri }}</a></td>
  </tr>
{% endfor %}

</table>
