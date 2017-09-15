---
layout: home
title: The NISP Nation
live-location: http://live.nisp.nw3.dk/
debug-location: http://live.nisp.nw3.dk/debug
archive-location: http://archive.nisp.nw3.dk
---

The NISP tools and the NISP database viewer are continously being updated, but only released officially once a year.

In order for the members of IP CaT to keep up with the development, this page provides online access to draft HTML5 and PDF editions of the NISP and the database viewer.

The sources to both the documents and the database viewer are stored in a Git repository at Github.

* Any change to the NISP tool/document/database repository will immediately trigger a continous integration / continous delivery pipeline, which result in a new version of NISP and an updated statistic of the standards and profiles.
* A local copy of the NISP database viewer is synchronized with the Github master twice a day - at 05:00 CET and 17:00 CET - and subsequently transformed and made availible on this page.


<hr />

<div class="link-box">

  <div class="quick-links">
    <h4>Go see draft stuff</h4>
    <ul class="daily">
      <li><a href="{{ page.live-location }}">See the latest draft of NISP</a></li>
      <li><a href="http://noswg.nw3.dk/thenispnation/dailyviewer/">Use the database viewer</a></li>
      <li><a href="http://noswg.nw3.dk/thenispnation/dailyviewer.public/">Use the database viewer (public edition)</a></li>
    </ul>
    <h4>Official releases</h4>
    <ul>
      <li><a href="{{ page.archive-location}}/nisp-9.0/">NISP v9</a> - Jul. 4, 2016</li>
      <li><a href="{{ page.archive-location}}/nisp-8.0/">NISP v8</a> - Aug. 22, 2014</li>
      <li><a href="{{ page.archive-location}}/nisp-7.0/">NISP v7</a> - Mar. 22, 2013</li>
<!--    
      <li><a href="{{ page.archive-location}}/nisp-6.0/">NISP v6</a> - Jan. 19, 2012</li>
-->
    </ul>
<!--
    <p><iframe src="https://spreadsheets.google.com/feeds/cells/11NmCRp1bc1Hbg38XM-lbKduwK9B3ibEyP5xMh88rB2M/1/public/full/Z332"><iframe></p>
-->
  </div>

  <div class="git-links">
    <h4>Get the sources</h4>

    <p>The NISP sources are freely availible at <a href="https://github.com/stavnstrup/nisp-tools">Github</a></p>
    <p>If you want to contribute to the NISP project, you can submit a <a href="https://help.github.com/articles/creating-a-pull-request/">pull request</a> to the repository.</p>
  </div>

</div>

<hr/>

#### Statistics

{% include stat.html %}

<hr />

#### Debugging the NISP database

* [Overview of all standards and profiles]({{page.debug-location}}/overview.html)
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