FROM japaric/i686-linux-android

COPY android-system.sh /
RUN bash /android-system.sh x86

ENV ANDROID_DNS_MODE=local \
    CARGO_TARGET_I686_LINUX_ANDROID_RUNNER="qemu-i386 -cpu n270"
