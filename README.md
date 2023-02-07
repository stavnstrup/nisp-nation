# nisp-nation

[![Linux Build Status](https://github.com/stavnstrup/nisp-nation/actions/workflows/gh-pages-deployment.yml/badge.svg)](https://github.com/stavnstrup/nisp-nation/actions)

Hugo based generation of the NISP website

The XSLT stylesheet is used to transform the NISP database, fetched by GitHub actions at http://github.com/stavnstrup/nisp-tools in the directory src/standards/.

Subsequently the XSLT stylesheet *db2data.xsl* in the *_xslt* directory is applied to the database resulting in YAML representations of all objects in the database. The objects are stored in files in Hugo content sections, which is subsequently processed by Hugo. The complete process is documented in the GitHub actions file gh-pages-deployment.yml.
