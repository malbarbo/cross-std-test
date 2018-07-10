FROM japaric/armv7-linux-androideabi

COPY android-system.sh /
RUN bash /android-system.sh arm

COPY qemu.sh /
RUN bash /qemu.sh arm

ENV ANDROID_DNS_MODE=local
