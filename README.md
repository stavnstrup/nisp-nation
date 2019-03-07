# nisp-nation
Jekyll based generation of the NISP website

The XSLT stylesheet is used to transform the NISP database, fetched by travis at http://github.com/stavnstrup/nisp-tools in the directory src/standards/.

Subsequently the XSLT stylesheet *db2data.xsl* in *_xslt* directory is applied to the database resulting in yaml representations of all objects in the database. The objects are stored in Jekyll collections, which is subsequently processed by Jekyll. The complete process is documented in the Travis configuration file.
