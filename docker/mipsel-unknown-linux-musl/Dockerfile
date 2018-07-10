FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bzip2 \
        ca-certificates \
        curl \
        gcc \
        libc6-dev

COPY musl-mipsel.sh /
RUN bash /musl-mipsel.sh

ENV STAGING_DIR=/tmp

COPY qemu.sh /
RUN bash /qemu.sh mipsel

ENV CARGO_TARGET_MIPSEL_UNKNOWN_LINUX_MUSL_LINKER=mipsel-openwrt-linux-gcc \
    CC_mipsel_unknown_linux_musl=mipsel-openwrt-linux-gcc \
    CARGO_TARGET_MIPSEL_UNKNOWN_LINUX_MUSL_RUNNER=qemu-mipsel \
    RUST_TEST_THREADS=1 \
    QEMU_LD_PREFIX=/usr/local/mipsel-linux-musl/

