curl -L https://gist.githubusercontent.com/n30m1nd/28d193d99e02ad572927905cb315aad8/raw/31fe4d7df5db8d00c5e246b0f6b0b27c11f8de7e/apatching_apache_for_AFL_fuzzing.diff > apatching_apache_for_AFL_fuzzing.diff
CC="afl-clang" CXX="afl-clang++" ./compile_httpd_with_flags.sh
cd httpd-2.4.37/
make install
cd ..
afl-fuzz -i input/ -o output/ -m none -t 2000 -- /usr/local/apache_clean/bin/httpd -X -F @@
