echo "changing opam environment"
opam switch 4.07+afl
eval $(opam env)
echo "installing QuickChick and FuzzChick"
opam repo -a add coq-released https://coq.inria.fr/opam/released
git clone -b FuzzChick https://github.com/QuickChick/QuickChick.git
opam pin add QuickChick
echo "preparing apache server"
curl -L https://www-us.apache.org/dist//apr/apr-1.6.5.tar.bz2 | tar xj
curl -L https://www-us.apache.org/dist//apr/apr-util-1.6.1.tar.bz2 | tar xj
svn checkout http://svn.apache.org/repos/asf/httpd/httpd/branches/2.4.x httpd-2.4.x
curl -L https://github.com/nghttp2/nghttp2/releases/download/v1.34.0/nghttp2-1.34.0.tar.xz | tar xJ
curl ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.42.tar.bz2 | tar xj
echo "configuring apache server"
cd httpd-2.4.x
curl -L https://gist.githubusercontent.com/n30m1nd/28d193d99e02ad572927905cb315aad8/raw/apatching_apache_for_AFL_fuzzing.diff | patch -p0
cd ..
curl -L https://gist.githubusercontent.com/liyishuai/43c5bb91187c85f163227ffb3cbeb836/raw/compile_httpd_with_flags.sh | CC="afl-clang" CXX="afl-clang++" bash
make -C httpd-2.4.x install
