FROM ubuntu:xenial

MAINTAINER ngot "https://github.com/ngot"

RUN apt-get update && \ 
	apt-get -y install g++-multilib build-essential && \
	rm -f /usr/include/asm && \
	ln -s x86_64-linux-gnu /usr/include/i386-linux-gnu && \
	ln -s x86_64-linux-gnu /usr/include/x86_64-linux-gnux32 && \
    apt-get -y --no-install-recommends install make cmake xz-utils git clang-6.0 && \
    apt-get install g++-5-arm-linux-gnueabihf -y && \
    rm -f /usr/bin/arm-linux-gnueabihf-gcc && \
    rm -f /usr/bin/arm-linux-gnueabihf-g++ && \
    ln -s arm-linux-gnueabihf-gcc-5 /usr/bin/arm-linux-gnueabihf-gcc && \
    ln -s arm-linux-gnueabihf-g++-5 /usr/bin/arm-linux-gnueabihf-g++ && \
	apt-get install g++-5-aarch64-linux-gnu -y && \
    rm -f /usr/bin/aarch64-linux-gnu-gcc && \
	rm -f /usr/bin/aarch64-linux-gnu-g++ && \
	ln -s aarch64-linux-gnu-gcc-5 /usr/bin/aarch64-linux-gnu-gcc && \
	ln -s aarch64-linux-gnu-g++-5 /usr/bin/aarch64-linux-gnu-g++ && \
	apt-get install g++-5-mips-linux-gnu -y && \
	rm -f /usr/bin/mips-linux-gnu-gcc && \
	rm -f /usr/bin/mips-linux-gnu-g++ && \
	ln -s mips-linux-gnu-gcc-5 /usr/bin/mips-linux-gnu-gcc && \
	ln -s mips-linux-gnu-g++-5 /usr/bin/mips-linux-gnu-g++ && \
	apt-get install g++-5-mips64-linux-gnuabi64 -y && \
	rm -f /usr/bin/mips64-linux-gnuabi64-gcc && \
	rm -f /usr/bin/mips64-linux-gnuabi64-g++ && \
	ln -s mips64-linux-gnuabi64-gcc-5 /usr/bin/mips64-linux-gnuabi64-gcc && \
	ln -s mips64-linux-gnuabi64-g++-5 /usr/bin/mips64-linux-gnuabi64-g++ && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /usr/share/doc && \
	rm -rf /usr/share/man