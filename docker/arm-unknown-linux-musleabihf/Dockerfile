FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bzip2 \
        ca-certificates \
        curl \
        gcc \
        gcc-arm-linux-gnueabihf \
        libc6-dev \
        libc6-dev-armhf-cross \
        make

COPY qemu.sh /
RUN bash /qemu.sh arm

COPY musl.sh /
RUN CC=arm-linux-gnueabihf-gcc \
    CFLAGS="-march=armv6 -marm" \
    bash /musl.sh arm

ENV CARGO_TARGET_ARM_UNKNOWN_LINUX_MUSLEABIHF_LINKER=/musl-arm/bin/musl-gcc \
    CARGO_TARGET_ARM_UNKNOWN_LINUX_MUSLEABIHF_RUNNER=qemu-arm \
    CC_arm_unknown_linux_musleabihf=/musl-arm/bin/musl-gcc \
    RUST_TEST_THREADS=1
