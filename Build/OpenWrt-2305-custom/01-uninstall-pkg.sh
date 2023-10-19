#!/bin/bash
#

# uninstall unsupported packages

./scripts/feeds uninstall nat6-scripts # will not work with new firewall
./scripts/feeds uninstall nodogsplash # as for jul-2023 leads to package/config conflict with opendns, may be fixed in future
./scripts/feeds uninstall pymysql # as for oct-2023 leads to recursive dependency: symbol PACKAGE_python3-pymysql depends on PYTHON3_PYMYSQL_SHA_PASSWORD_SUPPORT
