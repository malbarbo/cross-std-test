FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bzip2 \
        ca-certificates \
        curl \
        gcc \
        libc6-dev

COPY musl-mips.sh /
RUN bash /musl-mips.sh

ENV STAGING_DIR=/tmp

COPY qemu.sh /
RUN bash /qemu.sh mips linux

ENV CARGO_TARGET_MIPS_UNKNOWN_LINUX_MUSL_LINKER=mips-openwrt-linux-gcc \
    CC_mips_unknown_linux_musl=mips-openwrt-linux-gcc \
    CARGO_TARGET_MIPS_UNKNOWN_LINUX_MUSL_RUNNER=qemu-mips \
    RUST_TEST_THREADS=1 \
    QEMU_LD_PREFIX=/usr/local/mips-linux-musl/

