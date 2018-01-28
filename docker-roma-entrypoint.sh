#!/bin/bash

sed -i -e "s+.*define.*oxgarage_server.*+define (\'oxgarage_server\',\'${OXGARAGE_SERVER}\');+" ${WWW_HOME}/tei-roma/roma/config.php

# call the entrypoint script from the source image php:7-apache
exec apache2-foreground