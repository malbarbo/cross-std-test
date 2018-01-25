FROM japaric/x86_64-linux-android

COPY android-system.sh /
RUN bash /android-system.sh x86_64

COPY qemu.sh /
RUN bash /qemu.sh x86_64 android

ENV ANDROID_DNS_MODE=local \
    CARGO_TARGET_X86_64_LINUX_ANDROID_RUNNER="qemu-x86_64 -cpu Penryn" \
    RUST_TEST_THREADS=1
