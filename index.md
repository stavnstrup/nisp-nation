---
layout: home
title: The NISP Nation
live-location: https://live.nisp.nw3.dk/
debug-location: https://live.nisp.nw3.dk/debug
archive-location: https://archive.nisp.nw3.dk
---

The NISP tools and the NISP database viewer are continously being updated, but only officially released once a year.

In order for the members of IP CaT to keep up with the development, this page provides online access to draft HTML5 and PDF editions of the NISP and the database viewer.

The sources to both the documents and the database viewer are stored in a Git repository at GitHub.

* Any change to the NISP tool/document/database repository will immediately trigger a continous integration / continous delivery pipeline. This results in a new version of NISP and an updated statistical overview of the standards and profiles.
* A local copy of the NISP database viewer is synchronized with the GitHub master twice a day - at 05:00 CET and 17:00 CET - and subsequently transformed and made availible on this page.

<hr />

<div class="link-box">

  <div class="quick-links">
    <h4>Go see draft stuff</h4>
    <ul class="daily">
      <li><a href="{{ page.live-location }}">See the latest draft of NISP</a></li>
      <li><a href="http://noswg.nw3.dk/thenispnation/dailyviewer/">Use the database viewer</a></li>
      <li><a href="http://noswg.nw3.dk/thenispnation/dailyviewer.public/">Use the database viewer (public edition)</a></li>
    </ul>

  </div>

  <div class="git-links">
    <h4>Get the sources</h4>

    <p>The NISP sources are freely available at <a href="https://github.com/stavnstrup/nisp-tools">GitHub</a></p>
    <p>If you want to contribute to the NISP project, you can submit a <a href="https://help.github.com/articles/creating-a-pull-request/">pull request</a> to the repository.</p>
  </div>
</div>

<h4>Official releases</h4>
<ul>
  <li><a href="{{ page.archive-location}}/nisp-12.0/">DRAFT NISP v12 / ADatP-34(L) submitted to the C3B</a> -
  Jul. 11, 2019  - also as <a href="{{ page.archive-location}}/nisp-web-12.0-release.zip">web archive</a></li>
  <li><a href="{{ page.archive-location}}/nisp-11.0/">NISP v11 / ADatP-34(K)</a> -
  Aug. 3, 2018  - also as <a href="{{ page.archive-location}}/nisp-web-11.0-release.zip">web archive</a></li>
  <li><a href="{{ page.archive-location}}/nisp-10.0/">NISP v10 / ADatP-34(J)</a> -
  Oct. 2, 2017  - also as <a href="{{ page.archive-location}}/nisp-web-10.0-release.zip">web archive</a></li>
  <li><a href="{{ page.archive-location}}/nisp-9.0/">NISP v9 / ADatP-34(I)</a> -
  Jul. 4, 2016 - also as <a href="{{ page.archive-location}}/nisp-web-9.0-release.zip">web archive</a></li>
  <li><a href="{{ page.archive-location}}/nisp-8.0/">NISP v8 / ADatP-34(H)</a> -
  Aug. 22, 2014  - also as <a href="{{ page.archive-location}}/nisp-web-8.0-release.zip">web archive</a></li>
  <li><a href="{{ page.archive-location}}/nisp-7.0/">NISP v7 / ADatP-34(G)</a> -
  Mar. 22, 2013 - also as <a href="{{ page.archive-location}}/nisp-web-7.0-release.zip">web archive</a></li>
  <li><a href="{{ page.archive-location}}/nisp-6.0/">NISP v6 / ADatP-34(F)</a> -
  Jan. 19, 2012 (also as <a href="{{ page.archive-location}}/nisp-web-6.0-release.zip">web archive</a>)</li>
</ul>

<hr/>

#### Statistics
 
{% include stat.html %}

<hr />

#### Coherency Checks of the NISP Database

* [Overview of all standards and profiles incl. deleted elements]({{page.debug-location}}/overview.html)
* [Overview of all standards and profiles]({{page.debug-location}}/current.html)
* [Events in the database]({{page.debug-location}}/dates.html)
* [Responsible parties]({{page.debug-location}}/responsibleparties.html)
* [Candidate and fading standards]({{page.debug-location}}/upcoming.html)
* [Parent/child relationship]({{page.debug-location}}/family.html)

<!--
* [Overview of all standards and profiles](/debug/overview.html)
* [Events in the database](/debug/dates.html)
-->

<hr />

<div class="footer">
  <p>Last updated on {{ site.time | date_to_rfc822 }}</p>
</div>
