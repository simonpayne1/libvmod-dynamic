FROM debian:bullseye-slim AS builder

WORKDIR     /workspace
COPY        . .

RUN apt-get update
RUN apt-get install libgetdns-dev automake curl -y
RUN apt-get install build-essential libtool docutils-common -y

RUN curl -s https://packagecloud.io/install/repositories/varnishcache/varnish73/script.deb.sh |  bash
RUN apt-get install varnish-dev=7.3.2-1~bullseye -y

RUN ./autogen.sh
RUN ./configure
RUN make

FROM debian:bullseye-slim AS output
WORKDIR /output
COPY --from=builder /workspace/src/.libs/libvmod_dynamic.so /output/libvmod_dynamic.so

CMD ["tar", "czf", "/output.tar.gz", "/output"]


