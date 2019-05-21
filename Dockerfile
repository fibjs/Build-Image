FROM ubuntu:18.04

WORKDIR /fibjs

RUN apt-get update
RUN apt-get install software-properties-common -y
RUN add-apt-repository 'deb http://us.archive.ubuntu.com/ubuntu/ bionic main restricted universe multiverse' && \
add-apt-repository 'deb http://us.archive.ubuntu.com/ubuntu/ bionic-updates main restricted universe multiverse' && \
add-apt-repository 'deb http://us.archive.ubuntu.com/ubuntu/ bionic-backports main restricted universe multiverse' && \
add-apt-repository 'deb http://security.ubuntu.com/ubuntu bionic-security main restricted universe multiverse'

RUN apt-get update
RUN apt-get install curl g++ make cmake git g++-multilib qemu qemu-user-static binfmt-support -y

# https://apt.llvm.org/
# http://clang.llvm.org/docs/CrossCompilation.html
RUN curl https://apt.llvm.org/llvm-snapshot.gpg.key > /fibjs/llvm-snapshot.gpg.key
RUN apt-key add llvm-snapshot.gpg.key
RUN apt-add-repository "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-7 main"
RUN apt-get update
RUN apt-get install -y clang-7
RUN ln -s clang-7 /usr/bin/clang
RUN ln -s clang++-7 /usr/bin/clang++

RUN rm -f /usr/include/asm
RUN ln -s x86_64-linux-gnu /usr/include/i386-linux-gnu
RUN ln -s x86_64-linux-gnu /usr/include/x86_64-linux-gnux32

RUN apt-get install g++-5-arm-linux-gnueabihf -y
RUN rm -f /usr/bin/arm-linux-gnueabihf-gcc
RUN rm -f /usr/bin/arm-linux-gnueabihf-g++
RUN ln -s arm-linux-gnueabihf-gcc-5 /usr/bin/arm-linux-gnueabihf-gcc
RUN ln -s arm-linux-gnueabihf-g++-5 /usr/bin/arm-linux-gnueabihf-g++

RUN apt-get install g++-5-aarch64-linux-gnu -y
RUN rm -f /usr/bin/aarch64-linux-gnu-gcc
RUN rm -f /usr/bin/aarch64-linux-gnu-g++
RUN ln -s aarch64-linux-gnu-gcc-5 /usr/bin/aarch64-linux-gnu-gcc
RUN ln -s aarch64-linux-gnu-g++-5 /usr/bin/aarch64-linux-gnu-g++

RUN apt-get install g++-5-mips-linux-gnu -y
RUN rm -f /usr/bin/mips-linux-gnu-gcc
RUN rm -f /usr/bin/mips-linux-gnu-g++
RUN ln -s mips-linux-gnu-gcc-5 /usr/bin/mips-linux-gnu-gcc
RUN ln -s mips-linux-gnu-g++-5 /usr/bin/mips-linux-gnu-g++

RUN apt-get install g++-5-mips64-linux-gnuabi64 -y
RUN rm -f /usr/bin/mips64-linux-gnuabi64-gcc
RUN rm -f /usr/bin/mips64-linux-gnuabi64-g++
RUN ln -s mips64-linux-gnuabi64-gcc-5 /usr/bin/mips64-linux-gnuabi64-gcc
RUN ln -s mips64-linux-gnuabi64-g++-5 /usr/bin/mips64-linux-gnuabi64-g++

RUN apt-get install g++-5-arm-linux-gnueabihf -y
RUN rm -f /usr/bin/arm-linux-gnueabihf-gcc
RUN rm -f /usr/bin/arm-linux-gnueabihf-g++
RUN ln -s arm-linux-gnueabihf-gcc-5 /usr/bin/arm-linux-gnueabihf-gcc
RUN ln -s arm-linux-gnueabihf-g++-5 /usr/bin/arm-linux-gnueabihf-g++

ADD arm_root_fs /home/arm_root_fs
RUN cp $(which qemu-arm-static) /home/arm_root_fs/$(which qemu-arm-static)
ADD init_armhf.sh /home/init_armhf.sh

ADD arm64_root_fs /home/arm64_root_fs
RUN cp $(which qemu-aarch64-static) /home/arm64_root_fs/$(which qemu-aarch64-static)
ADD init_arm64.sh /home/init_arm64.sh
