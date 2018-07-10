FROM japaric/x86_64-linux-android

COPY android-system.sh /
RUN bash /android-system.sh x86_64

COPY qemu.sh /
RUN bash /qemu.sh x86_64

ENV ANDROID_DNS_MODE=local
