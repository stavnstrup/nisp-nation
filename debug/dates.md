---
layout: default
---

<h2>Dates</h2>

{% assign v_events = site.data.events | group_by: "version" %}

<table border="1" width="100%">
<tr>
  <th>Rec</th>
  <th>Type</th>
  <th>Id</th>
  <th>Tag</th>
  <th>Date</th>
  <th>Flag</th>
  <th>RFCP</th>
  <th>Version</th>
</tr>


{% for v in v_events %}
{%if v.name == '0.0' %}{% break %}{% endif %}
<tr><th class="versionhead" colspan="8">Version {{v.name}}</th></tr>
{% for e in v.items %}
<tr>
  <td>{{e.rec}}</td>
  <td>TYPE</td>
  <td>{{e.nisp-id}}</td>
  <td>{{e.tag}}</td>
  <td>{{e.date}}</td>
  <td>{{e.flag}}</td>
  <td>{{e.rfcp}}</td>
  <td>{{e.version}}</td>
</tr>
{% endfor %}
{% endfor %}

</table>
