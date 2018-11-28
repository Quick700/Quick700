curl -L https://www-us.apache.org/dist//apr/apr-1.6.5.tar.bz2 | tar xj
curl -L https://www-us.apache.org/dist//apr/apr-util-1.6.1.tar.bz2 | tar xj
curl -L https://github.com/apache/httpd/archive/2.4.24.tar.gz | tar xz
curl -L https://github.com/nghttp2/nghttp2/releases/download/v1.34.0/nghttp2-1.34.0.tar.xz | tar xJ
git clone https://github.com/eatonphil/mod_ocaml.git
sed -i -e 's+/usr/local/apache/+/root/apache_clean/+g' /~/mod_ocaml/make.sh
curl ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.42.tar.bz2 | tar xj
curl -L https://gist.githubusercontent.com/liyishuai/43c5bb91187c85f163227ffb3cbeb836/raw/compile_httpd_with_flags.sh | CC="afl-clang" CXX="afl-clang++" bash
make -C httpd-2.4.24 install
