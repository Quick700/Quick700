#!/bin/sh
honggfuzz/honggfuzz -f hong-apache/corpus_http1 -w hong-apache/httpd.wordlist -- ./dist/bin/httpd -DFOREGROUND -f /home/honggfuzz/httpd.conf.h1 ___FILE___
