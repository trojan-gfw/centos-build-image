FROM centos:7

RUN yum install -y gcc-c++ make perl \
    \
    && curl -LO https://github.com/Kitware/CMake/releases/download/v3.15.6/cmake-3.15.6.tar.gz \
    && tar xf cmake-3.15.6.tar.gz \
    && cd cmake-3.15.6 \
    && ./bootstrap -- \
    && make install \
    && cd .. \
    && rm -rf cmake-3.15.6.tar.gz cmake-3.15.6 \
    \
    && curl -LO https://dl.bintray.com/boostorg/release/1.72.0/source/boost_1_72_0.tar.gz \
    && tar xf boost_1_72_0.tar.gz \
    && cd boost_1_72_0 \
    && ./bootstrap.sh \
    && ./b2 --with-system --with-program_options variant=release link=static threading=multi runtime-link=shared install \
    && cd .. \
    && rm -rf boost_1_72_0.tar.gz boost_1_72_0 \
    \
    && curl -LO https://www.openssl.org/source/openssl-1.1.1d.tar.gz \
    && tar xf openssl-1.1.1d.tar.gz \
    && cd openssl-1.1.1d \
    && ./config --openssldir=/etc/ssl enable-ec_nistp_64_gcc_128 no-ssl2 no-ssl3 no-comp no-idea no-dtls no-dtls1 no-shared no-psk no-srp no-ec2m no-weak-ssl-ciphers \
    && make install_sw \
    && cd .. \
    && rm -rf openssl-1.1.1d.tar.gz openssl-1.1.1d \
    \
    && curl -LO https://downloads.mariadb.org/f/mariadb-10.4.11/source/mariadb-10.4.11.tar.gz \
    && tar xf mariadb-10.4.11.tar.gz \
    && cd mariadb-10.4.11 \
    && mkdir build \
    && cd build \
    && cmake -DWITH_CURL=OFF -DWITH_DYNCOL=OFF -DWITH_MYSQLCOMPAT=ON -DWITH_SSL=OFF -DWITH_UNIT_TESTS=OFF ../libmariadb \
    && make install \
    && cd ../.. \
    && rm -rf mariadb-10.4.11.tar.gz mariadb-10.4.11
