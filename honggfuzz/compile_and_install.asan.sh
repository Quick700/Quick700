#!/bin/sh

set -ex

# Directory with honggfuzz installation
HFUZZ_DIR="$(realpath "$PWD/../honggfuzz")"
# Change this to a directory where apache should be installed into
INSTALL_PREFIX="$(realpath "$PWD/../dist")"
CFLAGS_SAN="-fsanitize=address -O3 -ggdb"
# Another viable option: few
APACHE_MODULES=most

NGHTTP2_PATH="$(realpath "$PWD/../nghttp2")/"
APR_PATH="$(realpath "$PWD/../apr")"
APR_UTIL_PATH="$(realpath "$PWD/../apr-util")/"

export CC="$HFUZZ_DIR/hfuzz_cc/hfuzz-clang"
export CXX="$HFUZZ_DIR/hfuzz_cc/hfuzz-clang++"

echo "Compiling APR"
cd "$APR_PATH"
./buildconf
touch libtoolT
CFLAGS="$CFLAGS_SAN" ./configure --disable-shared --enable-static
make clean
make -j$(nproc)
cd -

echo "Compiling APR-UTIL"
cd "$APR_UTIL_PATH"
./buildconf
touch libtoolT
CFLAGS="$CFLAGS_SAN" ./configure --with-apr="$APR_PATH" --disable-shared --enable-static
make clean
make -j$(nproc)
cd -

echo "Compiling NGHTTP2"
cd "$NGHTTP2_PATH"
autoreconf -i
automake
autoconf
CFLAGS="$CFLAGS_SAN -fPIC" CXXFLAGS="$CFLAGS_SAN -fPIC" ./configure --disable-shared --enable-static
make clean
make -j$(nproc)
cd -

echo "Install PATH: $INSTALL_PREFIX"
./buildconf --with-apr="$APR_PATH" --with-apr-util="$APR_UTIL_PATH"

echo "Compiling HTTPD"
CFLAGS="-I$NGHTTP2_PATH/lib/includes $CFLAGS_SAN -ggdb -O3" LDFLAGS="-L$NGHTTP2_PATH/lib -lpthread -fsanitize=address" \
./configure \
		--prefix="$INSTALL_PREFIX" \
		--with-nghttp2="$NGHTTP2_PATH/" \
		--enable-http2 \
		--enable-nghttp2-staticlib-deps \
		--with-mpm=event \
		--enable-unixd \
		--disable-pie \
		--disable-ssl \
		--enable-mods-static=$APACHE_MODULES \
		--with-apr="$APR_PATH" \
		--with-apr-util="$APR_UTIL_PATH"
make clean
make -j$(nproc)
make install
