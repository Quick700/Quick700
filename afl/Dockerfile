FROM debian:jessie
WORKDIR ~
COPY input input
RUN apt-get update && apt-get install -y python-dev apt-utils autoconf build-essential curl libexpat1-dev libtool sudo pkg-config libssl-dev subversion\
 && curl http://releases.llvm.org/4.0.1/clang+llvm-4.0.1-x86_64-linux-gnu-debian8.tar.xz | tar xJ -C /usr/local --strip-components=1 \
 && curl http://lcamtuf.coredump.cx/afl/releases/afl-2.52b.tgz | tar xz \
 && make -C afl-2.52b && make -C afl-2.52b/llvm_mode && make -C afl-2.52b install \
 && curl -L https://www-us.apache.org/dist//apr/apr-1.6.5.tar.bz2 | tar xj \
 && curl -L https://www-us.apache.org/dist//apr/apr-util-1.6.1.tar.bz2 | tar xj \
 && curl -L https://www-us.apache.org/dist//httpd/httpd-2.4.37.tar.bz2 | tar xj \
 && curl -L https://github.com/nghttp2/nghttp2/releases/download/v1.34.0/nghttp2-1.34.0.tar.xz | tar xJ \
 && curl ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.42.tar.bz2 | tar xj \
 && curl -L https://gist.githubusercontent.com/n30m1nd/14418fd425a3b2d14b64650710fae301/raw/e1cff738eb1ffaa55cb8a1a66bb1a2b06ed7f97e/compile_httpd_with_flags.sh | sed "s/skylake/native/" > compile_httpd_with_flags.sh \
 && chmod +x compile_httpd_with_flags.sh \
 && curl -L https://raw.githubusercontent.com/Quick700/Quick700/master/afl/setup.sh > setup.sh \
 && chmod +x setup.sh \
 && ./setup.sh
 CMD afl-fuzz -i input/ -o output/ -m none -t 2000 -- /usr/local/apache_clean/bin/httpd -X -F @@
