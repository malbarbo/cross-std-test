FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bzip2 \
        ca-certificates \
        curl \
        gcc \
        libc6-dev

COPY toolchain-armhf.sh /
RUN bash /toolchain-armhf.sh

ENV PATH="$PATH:/gcc/bin"

COPY qemu.sh /
RUN bash /qemu.sh arm

ENV CARGO_TARGET_ARM_UNKNOWN_LINUX_GNUEABIHF_LINKER=arm-linux-gcc \
    CARGO_TARGET_ARM_UNKNOWN_LINUX_GNUEABIHF_RUNNER=qemu-arm \
    QEMU_LD_PREFIX=/gcc/arm-buildroot-linux-gnueabihf/sysroot/ \
    CC_arm_unknown_linux_gnueabihf=arm-linux-gcc \
    RUST_TEST_THREADS=1
