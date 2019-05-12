FROM ubuntu:18.04

WORKDIR /fibjs

RUN apt-get update
RUN apt-get install -q software-properties-common -y
RUN add-apt-repository 'deb http://us.archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse' && \
add-apt-repository 'deb http://us.archive.ubuntu.com/ubuntu/ xenial-updates main restricted universe multiverse' && \
add-apt-repository 'deb http://us.archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse' && \
add-apt-repository 'deb http://security.ubuntu.com/ubuntu xenial-security main restricted universe multiverse'

RUN apt-get update
RUN apt-get install -q curl g++ make cmake git g++-multilib qemu qemu-user-static binfmt-support -y

# https://apt.llvm.org/
# http://clang.llvm.org/docs/CrossCompilation.html
RUN curl https://apt.llvm.org/llvm-snapshot.gpg.key > /fibjs/llvm-snapshot.gpg.key
RUN apt-key add llvm-snapshot.gpg.key
RUN apt-add-repository "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-8 main"
RUN apt-get update
RUN apt-get install -q -y clang-8
RUN ln -s clang-8 /usr/bin/clang
RUN ln -s clang++-8 /usr/bin/clang++

RUN rm -f /usr/include/asm
RUN ln -s x86_64-linux-gnu /usr/include/i386-linux-gnu
RUN ln -s x86_64-linux-gnu /usr/include/x86_64-linux-gnux32

RUN apt-get install -q g++-5-arm-linux-gnueabihf -y
RUN rm -f /usr/bin/arm-linux-gnueabihf-gcc
RUN rm -f /usr/bin/arm-linux-gnueabihf-g++
RUN ln -s arm-linux-gnueabihf-gcc-5 /usr/bin/arm-linux-gnueabihf-gcc
RUN ln -s arm-linux-gnueabihf-g++-5 /usr/bin/arm-linux-gnueabihf-g++

RUN apt-get install -q g++-5-aarch64-linux-gnu -y
RUN rm -f /usr/bin/aarch64-linux-gnu-gcc
RUN rm -f /usr/bin/aarch64-linux-gnu-g++
RUN ln -s aarch64-linux-gnu-gcc-5 /usr/bin/aarch64-linux-gnu-gcc
RUN ln -s aarch64-linux-gnu-g++-5 /usr/bin/aarch64-linux-gnu-g++

RUN apt-get install -q g++-5-mips-linux-gnu -y
RUN rm -f /usr/bin/mips-linux-gnu-gcc
RUN rm -f /usr/bin/mips-linux-gnu-g++
RUN ln -s mips-linux-gnu-gcc-5 /usr/bin/mips-linux-gnu-gcc
RUN ln -s mips-linux-gnu-g++-5 /usr/bin/mips-linux-gnu-g++

RUN apt-get install -q g++-5-mips64-linux-gnuabi64 -y
RUN rm -f /usr/bin/mips64-linux-gnuabi64-gcc
RUN rm -f /usr/bin/mips64-linux-gnuabi64-g++
RUN ln -s mips64-linux-gnuabi64-gcc-5 /usr/bin/mips64-linux-gnuabi64-gcc
RUN ln -s mips64-linux-gnuabi64-g++-5 /usr/bin/mips64-linux-gnuabi64-g++

RUN apt-get install -q g++-5-arm-linux-gnueabihf -y
RUN rm -f /usr/bin/arm-linux-gnueabihf-gcc
RUN rm -f /usr/bin/arm-linux-gnueabihf-g++
RUN ln -s arm-linux-gnueabihf-gcc-5 /usr/bin/arm-linux-gnueabihf-gcc
RUN ln -s arm-linux-gnueabihf-g++-5 /usr/bin/arm-linux-gnueabihf-g++

RUN apt-get install -q libc6-dev-arm64-cross -y

# fix qemu libc http://docs.pwntools.com/en/stable/qemu.html
RUN mkdir /etc/qemu-binfmt
RUN ln -s /usr/aarch64-linux-gnu /etc/qemu-binfmt/aarch64
RUN ln -s /usr/arm-linux-gnueabihf /etc/qemu-binfmt/arm

ADD arm_rootfs.tar.gz /home/arm_rootfs.tar.gz
ADD build_docker.sh /home/build_docker.sh
