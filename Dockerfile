FROM debian:bullseye-slim

RUN apt-get update \
	&& apt-get install -y --no-install-recommends xz-utils wget ca-certificates git cmake build-essential \
	&& wget -O zig.tar.xz https://ziglang.org/download/0.9.0/zig-linux-x86_64-0.9.0.tar.xz \
	&& mkdir -p /zig \
	&& tar -xf zig.tar.xz --strip-components=1 -C /zig \
	&& chmod +x /zig/zig \
	&& rm -rf zig.tar.xz

ENV PATH="${PATH}:/zig" \
	CXX="/zig/zigcc" \
	CC="/zig/zigcc"

COPY zigcc /zig/zigcc

RUN git clone https://github.com/metacall/core.git \
	&& mkdir -p core/build && cd core/build \
	&& cmake -DOPTION_BUILD_DOCS=OFF -DOPTION_FORK_SAFE=OFF -DOPTION_BUILD_TESTS=OFF .. \
	&& make -j$(nproc)
