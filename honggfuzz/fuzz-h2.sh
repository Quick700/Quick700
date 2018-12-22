#!/bin/sh
honggfuzz/honggfuzz -f hong-apache/corpus_http2 -w hong-apache/httpd.wordlist -- ./dist/bin/httpd -DFOREGROUND -f /home/honggfuzz/httpd.conf.h2 ___FILE___
