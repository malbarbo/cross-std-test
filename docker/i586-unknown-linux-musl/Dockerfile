FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bzip2 \
        ca-certificates \
        curl \
        gcc \
        libc6-dev \
        make

COPY qemu.sh /
RUN bash /qemu.sh i386

COPY musl.sh /
RUN CC=gcc \
    CFLAGS="-march=pentium -m32 -Wa,-mrelax-relocations=no" \
    bash /musl.sh i586 --target=i586

ENV CARGO_TARGET_I586_UNKNOWN_LINUX_MUSL_LINKER=/musl-i586/bin/musl-gcc \
    CARGO_TARGET_I586_UNKNOWN_LINUX_MUSL_RUNNER="qemu-i386 -cpu pentium" \
    CC_i586_unknown_linux_musl=/musl-i586/bin/musl-gcc \
    RUST_TEST_THREADS=1
