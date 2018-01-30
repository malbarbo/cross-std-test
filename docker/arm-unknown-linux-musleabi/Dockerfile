FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bzip2 \
        ca-certificates \
        curl \
        gcc \
        gcc-arm-linux-gnueabi \
        libc6-dev \
        libc6-dev-armel-cross \
        make

COPY qemu.sh /
RUN bash /qemu.sh arm linux

COPY musl.sh /
RUN CC=arm-linux-gnueabi-gcc \
    CFLAGS="-march=armv6" \
    bash /musl.sh arm

ENV CARGO_TARGET_ARM_UNKNOWN_LINUX_MUSLEABI_LINKER=/musl-arm/bin/musl-gcc \
    CARGO_TARGET_ARM_UNKNOWN_LINUX_MUSLEABI_RUNNER=qemu-arm \
    CC_arm_unknown_linux_musleabi=/musl-arm/bin/musl-gcc \
    RUST_TEST_THREADS=1
