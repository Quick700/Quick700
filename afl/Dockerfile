FROM debian:jessie
WORKDIR root
COPY . .
RUN apt-get update && apt-get install -y python-dev apt-utils autoconf build-essential curl libexpat1-dev libtool pkg-config libssl-dev subversion\
 && curl http://releases.llvm.org/4.0.1/clang+llvm-4.0.1-x86_64-linux-gnu-debian8.tar.xz | tar xJ -C /usr/local --strip-components=1 \
 && curl http://lcamtuf.coredump.cx/afl/releases/afl-2.52b.tgz | tar xz \
 && make -C afl-2.52b && make -C afl-2.52b/llvm_mode && make -C afl-2.52b install \
 && ./setup.sh
CMD ./fuzz.sh
