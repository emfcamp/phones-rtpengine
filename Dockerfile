FROM debian:trixie-slim AS builder

ARG RTPENGINE_TAG=mr13.5.1.10

# Set up deb-multimedia for AMR-capable ffmpeg build deps
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates \
    && echo "deb [trusted=yes] https://www.deb-multimedia.org trixie main non-free" \
        > /etc/apt/sources.list.d/deb-multimedia.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends deb-multimedia-keyring \
    && echo "deb https://www.deb-multimedia.org trixie main non-free" \
        > /etc/apt/sources.list.d/deb-multimedia.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        default-libmysqlclient-dev \
        g++ \
        gcc \
        git \
        gperf \
        libavcodec-dev \
        libavfilter-dev \
        libbcg729-dev \
        libcurl4-openssl-dev \
        libevent-dev \
        libglib2.0-dev \
        libhiredis-dev \
        libiptc-dev \
        libjson-glib-dev \
        libjwt-dev \
        libmnl-dev \
        libnftnl-dev \
        libncursesw5-dev \
        libopus-dev \
        libpcap-dev \
        libpcre2-dev \
        libspandsp-dev \
        libssl-dev \
        libwebsockets-dev \
        make \
        markdown \
        patch \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --branch "${RTPENGINE_TAG}" --depth 1 \
        https://github.com/sipwise/rtpengine.git /usr/src/rtpengine

WORKDIR /usr/src/rtpengine/daemon
RUN make -j$(nproc) rtpengine \
    && strip -o /usr/local/bin/rtpengine rtpengine

FROM debian:trixie-slim

# Set up deb-multimedia for AMR-capable ffmpeg runtime libs
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates \
    && echo "deb [trusted=yes] https://www.deb-multimedia.org trixie main non-free" \
        > /etc/apt/sources.list.d/deb-multimedia.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends deb-multimedia-keyring \
    && echo "deb https://www.deb-multimedia.org trixie main non-free" \
        > /etc/apt/sources.list.d/deb-multimedia.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        curl \
        iptables \
        libavcodec61 \
        libavfilter10 \
        libbcg729-0 \
        libcurl4 \
        libevent-2.1-7 \
        libevent-pthreads-2.1-7 \
        libglib2.0-0 \
        libhiredis1.1.0 \
        libip4tc2 \
        libip6tc2 \
        libjson-glib-1.0-0 \
        libjwt2 \
        libmariadb3 \
        libncursesw6 \
        libopus0 \
        libpcap0.8 \
        libpcre2-8-0 \
        libspandsp2 \
        libssl3 \
        libwebsockets19 \
        net-tools \
        procps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/bin/rtpengine /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/rtpengine"]
