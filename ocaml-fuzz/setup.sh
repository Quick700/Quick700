opam switch 4.07+afl
eval $(opam env)
opam repo -a add coq-released https://coq.inria.fr/opam/released
git clone -b FuzzChick https://github.com/QuickChick/QuickChick.git
opam pin add QuickChick
curl -L https://www-us.apache.org/dist//apr/apr-1.6.5.tar.bz2 | tar xj
curl -L https://www-us.apache.org/dist//apr/apr-util-1.6.1.tar.bz2 | tar xj
curl -L https://github.com/apache/httpd/archive/2.4.24.tar.gz | tar xz
curl -L https://github.com/nghttp2/nghttp2/releases/download/v1.34.0/nghttp2-1.34.0.tar.xz | tar xJ
curl ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.42.tar.bz2 | tar xj
curl -L https://gist.githubusercontent.com/n30m1nd/28d193d99e02ad572927905cb315aad8/raw/apatching_apache_for_AFL_fuzzing.diff | patch -p0
curl -L https://gist.githubusercontent.com/liyishuai/43c5bb91187c85f163227ffb3cbeb836/raw/compile_httpd_with_flags.sh | CC="afl-clang" CXX="afl-clang++" bash
make -C httpd-2.4.24 install
