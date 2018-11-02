FROM ubuntu
WORKDIR /home
COPY . .
RUN apt-get update \
 && apt-get install -y autoconf binutils-dev build-essential clang libblocksruntime-dev libexpat1-dev libpcre3-dev libtool-bin libunwind-dev pkg-config \
 && make -C honggfuzz
CMD ./compile.sh && bash
