FROM ocaml/opam2:ubuntu-16.04-ocaml-4.08
WORKDIR ..
COPY . .
RUN sudo apt-get update && sudo apt-get install -y python-dev apt-utils autoconf build-essential curl libexpat1-dev libtool pkg-config libssl-dev subversion git unzip vim libwww-perl wget \
 && curl http://releases.llvm.org/4.0.0/clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz | sudo tar xJ -C /usr/local --strip-components=1 \
 && curl http://lcamtuf.coredump.cx/afl/releases/afl-2.52b.tgz | tar xz \
 && make -C afl-2.52b && make -C afl-2.52b/llvm_mode && sudo make -C afl-2.52b install
