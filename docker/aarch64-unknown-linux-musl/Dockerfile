FROM japaric/aarch64-unknown-linux-gnu

COPY qemu.sh /
RUN bash /qemu.sh aarch64

COPY musl.sh /
RUN CC=aarch64-linux-gnu-gcc \
    bash /musl.sh aarch64

ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_MUSL_LINKER=/musl-aarch64/bin/musl-gcc \
    CARGO_TARGET_AARCH64_UNKNOWN_LINUX_MUSL_RUNNER=qemu-aarch64 \
    CC_aarch64_unknown_linux_musl=/musl-aarch64/bin/musl-gcc \
    RUSTFLAGS="-C link-arg=-lgcc"
