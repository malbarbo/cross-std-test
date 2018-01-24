set -ex

main() {
    local arch=$1
    local td=$(mktemp -d)
    pushd $td

    local dependencies=(
        ca-certificates
        curl
        gcc-multilib
        git
        g++-multilib
        make
        python
    )

    # fake java and javac, it is not necessary for what we build, but the build
    # script ask for it
    cat << EOF > /usr/bin/java
#!/bin/bash
echo "java version \"1.7.0\""
echo "OpenJDK Runtime Environment (IcedTea 2.6.9)"
echo "OpenJDK 64-Bit Server VM (build 24.131-b00, mixed mode)"
EOF

    cat << EOF > /usr/bin/javac
#!/bin/bash
echo "javac 1.7.0"
EOF

    chmod +x /usr/bin/java
    chmod +x /usr/bin/javac

    # more faking
    export ANDROID_JAVA_HOME=/tmp
    mkdir -p /tmp/lib/
    touch /tmp/lib/tools.jar

    apt-get update
    local purge_list=(default-jre)
    for dep in ${dependencies[@]}; do
        if ! dpkg -L $dep; then
            apt-get install --no-install-recommends -y $dep
            purge_list+=( $dep )
        fi
    done

    curl -O https://storage.googleapis.com/git-repo-downloads/repo
    chmod +x repo

    # this is the minimum set of modules that are need to build bionic
    # this was created by trial and error
    ./repo init -u https://android.googlesource.com/platform/manifest -b android-5.0.0_r1
    ./repo sync -c bionic
    ./repo sync -c build
    ./repo sync -c external/compiler-rt
    ./repo sync -c external/jemalloc
    ./repo sync -c external/libcxx
    ./repo sync -c external/libcxxabi
    ./repo sync -c external/libselinux
    ./repo sync -c external/mksh
    ./repo sync -c external/openssl
    ./repo sync -c external/stlport
    ./repo sync -c prebuilts/clang/linux-x86/host/3.5
    ./repo sync -c system/core
    case $arch in
        arm)
            ./repo sync prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.8
        ;;
        arm64)
            ./repo sync prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.8
            ./repo sync prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9
        ;;
        x86)
            ./repo sync prebuilts/gcc/linux-x86/x86/x86_64-linux-android-4.8
        ;;
        x86_64)
            ./repo sync prebuilts/gcc/linux-x86/x86/x86_64-linux-android-4.8
        ;;
    esac

    # avoid build tests
    rm bionic/linker/tests/Android.mk bionic/tests/Android.mk bionic/benchmarks/Android.mk

    # patch the linker to avoid the error
    # FATAL: kernel did not supply AT_SECURE
    sed -i -e 's/if (!kernel_supplied_AT_SECURE)/if (false)/g' bionic/linker/linker_environ.cpp

    source build/envsetup.sh
    lunch aosp_$arch-user
    mmma bionic/
    mmma external/mksh/
    mmma system/core/toolbox/

    rm -rf /system/
    if [ $arch = "arm" ]; then
        mv out/target/product/generic/system/ /
    else
        mv out/target/product/generic_$arch/system/ /
    fi

    # list from https://elinux.org/Android_toolbox
    for tool in cat chmod chown cmp cp ctrlaltdel date dd df dmesg du getevent \
        getprop grep hd id ifconfig iftop insmod ioctl ionice kill ln log ls \
        lsmod lsof lsusb md5 mkdir mount mv nandread netstat newfs_msdos notify \
        printenv ps reboot renice rm rmdir rmmod route schedtop sendevent \
        setconsole setprop sleep smd start stop sync top touch umount \
        uptime vmstat watchprops wipe; do
        ln -s /system/bin/toolbox /system/bin/$tool
    done

    echo "127.0.0.1 localhost" > /system/etc/hosts

    # clean up
    apt-get purge --auto-remove -y ${purge_list[@]}

    popd

    rm -rf $td
    rm $0
}

main "${@}"