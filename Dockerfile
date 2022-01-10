FROM debian:bullseye-slim

RUN apt-get update \
	&& apt-get install -y --no-install-recommends xz-utils wget ca-certificates \
	&& wget -O zig.tar.xz https://ziglang.org/download/0.9.0/zig-linux-x86_64-0.9.0.tar.xz \
	&& mkdir -p /zig \
	&& tar -xf zig.tar.xz --strip-components=1 -C /zig \
	&& chmod +x /zig/zig \
	&& rm -rf zig.tar.xz

ENV PATH="${PATH}:/zig"

COPY zigcc /zig/zigcc
