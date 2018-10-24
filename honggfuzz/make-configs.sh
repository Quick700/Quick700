#!/bin/sh

sed "s|\$HOME|$HOME|g" httpd-template.conf.h1 > httpd.conf.h1
sed "s|\$HOME|$HOME|g" httpd-template.conf.h2 > httpd.conf.h2
