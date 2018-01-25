FROM japaric/arm-unknown-linux-gnueabi

ENV CARGO_TARGET_ARMV5TE_UNKNOWN_LINUX_GNUEABI_LINKER=$CARGO_TARGET_ARM_UNKNOWN_LINUX_GNUEABI_LINKER \
    CARGO_TARGET_ARMV5TE_UNKNOWN_LINUX_GNUEABI_RUNNER=$CARGO_TARGET_ARM_UNKNOWN_LINUX_GNUEABI_RUNNER \
    CC_armv5te_unknown_linux_gnueabi=$CC_arm_unknown_linux_gnueabi \
    CFLAGS_armv5te_unknown_linux_gnueabi="-march=armv5te"
