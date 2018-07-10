FROM japaric/aarch64-linux-android

COPY android-system.sh /
RUN bash /android-system.sh arm64

COPY qemu.sh /
RUN bash /qemu.sh aarch64

ENV ANDROID_DNS_MODE=local
