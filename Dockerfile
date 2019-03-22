FROM ubuntu:xenial

MAINTAINER ngot "https://github.com/ngot"

RUN apt-get update && \
    apt-get -y --no-install-recommends install make cmake xz-utils git clang-6.0 g++-5-mips-linux-gnu g++-5-mips64-linux-gnuabi64 g++-5-powerpc-linux-gnu g++-5-powerpc64-linux-gnu g++-5-arm-linux-gnueabihf g++-5-aarch64-linux-gnu && \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-6.0 999 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-6.0 999 && \
    update-alternatives --install /usr/bin/mips-linux-gnu-gcc mips-linux-gnu-gcc /usr/bin/mips-linux-gnu-gcc-5 999 && \
	update-alternatives --install /usr/bin/mips-linux-gnu-g++ mips-linux-gnu-g++ /usr/bin/mips-linux-gnu-g++-5 999 && \
	update-alternatives --install /usr/bin/mips64-linux-gnuabi64-gcc mips64-linux-gnuabi64-gcc /usr/bin/mips64-linux-gnuabi64-gcc-5 999 && \
	update-alternatives --install /usr/bin/mips64-linux-gnuabi64-g++ mips64-linux-gnuabi64-g++ /usr/bin/mips64-linux-gnuabi64-g++-5 999 && \
	update-alternatives --install /usr/bin/arm-linux-gnueabihf-gcc arm-linux-gnueabihf-gcc /usr/bin/arm-linux-gnueabihf-gcc-5 999 && \
	update-alternatives --install /usr/bin/arm-linux-gnueabihf-g++ arm-linux-gnueabihf-g++ /usr/bin/arm-linux-gnueabihf-g++-5 999 && \
	update-alternatives --install /usr/bin/aarch64-linux-gnu-gcc aarch64-linux-gnu-gcc /usr/bin/aarch64-linux-gnu-gcc-5 999 && \
	update-alternatives --install /usr/bin/aarch64-linux-gnu-g++ aarch64-linux-gnu-g++ /usr/bin/aarch64-linux-gnu-g++-5 999 && \
	ln -s x86_64-linux-gnu /usr/include/i386-linux-gnu && \
	ln -s x86_64-linux-gnu /usr/include/x86_64-linux-gnux32 && \
	apt-get -y install g++-multilib && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /usr/share/doc && \
	rm -rf /usr/share/man