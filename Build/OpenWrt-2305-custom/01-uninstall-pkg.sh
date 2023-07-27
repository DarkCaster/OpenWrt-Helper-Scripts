#!/bin/bash
#

# uninstall unsupported packages

./scripts/feeds uninstall nat6-scripts # will not work with new firewall
./scripts/feeds uninstall nodogsplash # as for jul-2023 leads to package/config conflict with opendns, may be fixed in future
