#!/bin/bash
afl-fuzz -i input/ -o output/ -m none -- ~/apache_clean/bin/httpd -X -F @@
