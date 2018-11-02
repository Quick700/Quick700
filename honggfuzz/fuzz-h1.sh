#!/bin/sh
honggfuzz/honggfuzz -f hong-apache/corpus_http1 -w hong-apache/httpd.wordlist -- ./dist/bin/httpd -DFOREGROUND -f /Users/yishuai/quick700/honggfuzz/httpd.conf.h1 ___FILE___
