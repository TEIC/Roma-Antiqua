# Roma

The Roma tool at http://roma.tei-c.org/
provides a way of constructing ODD specifications
from which TEI schemas and documentation 
can be derived. 

## Introduction

Roma's basic job is to construct an XML document,
the TEI "ODD". To generate output, this
is processed using a set of XSLT stylesheets
which can produce RELAXNG schemas, W3C schemas,
HTML documentation, etc. This library
of XSLT is maintained separately, and can be
assumed to do the right thing.

Roma is originally written in PHP, supported by
XSLT stylesheets and requests to a data
source, using XQuery. It's basic interface
is to simulate state via a series of tabs;
each of these saves state in a PHP session
for the next call to the web site to read.


At various points, Roma offers lists of components
of the TEI; these are created by accessing
an eXist XML database, sending XQuery via HTTP.

## Installing and running

### with Docker

If you have Docker installed, you can fetch a readymade image from [Docker Hub](https://hub.docker.com/r/teic/roma/). Along with this image you'll need an eXist-db sidekick as backend which you can get from  https://hub.docker.com/r/teic/xquery4roma.

```bash
docker run --rm \
    -p 9090:80 \
    -v /your/path/to/TEIcustom/schemas:/usr/share/xml/tei/custom:ro \ 
    --name roma \
    teic/roma:dev
```

#### available parameters

* **OXGARAGE_SERVER** : The full URL of the 
    RESTful OxGarage *web service* which is used as the Roma backend 
    for creating schemas and documentation. 
    Defaults to `http://www.tei-c.org/ege-webservice`
* **ROMA_XQUERY_SERVER** : The full URL of the eXist database backend 
    which provides the XQueries.
    Defaults to `http://www.tei-c.org/Query/`  
* **ROMA_TEIWEB_SERVER** : The full URL to the TEI web server.
    Defaults to `http://www.tei-c.org/release/doc/tei-p5-doc/`.

#### Docker compose

The following Docker compose file should bring up the xquery4roma sidekick and the Roma web frontend, listening on your local port 9090. Simply save as `docker-compose.yml` and run `docker-compose up -d`. To stop and remove all services again, run `docker-compose down`.

```yaml
version: '3'

services:
    roma:
        image: teic/roma
        restart: always
        volumes:
            - /your/path/to/TEIcustom/schemas:/usr/share/xml/tei/custom:ro
        ports:
            - "9090:80"
        environment:
            OXGARAGE_SERVER: http://oxgarage.tei-c.org/ege-webservice
            ROMA_XQUERY_SERVER: http://xquery4roma:8080/Query/
    xquery4roma:
        image: teic/xquery4roma
        restart: always
```        


