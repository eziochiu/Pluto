FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN \
    dpkg --add-architecture i386 && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends \
    git-core \
    gnupg \
    flex \
    bison \
    build-essential \
    zip \
    libz3-dev \
    curl \
    zlib1g-dev \
    libc6-dev \
    libncurses5-dev \
    libssl-dev \
    libxml2-utils \
    xsltproc \
    unzip \
    fontconfig \
    \
    python3 \
    mingw-w64 \
    wget \
    rsync \
    openssh-client \
    ninja-build\
    cmake\
    gcc\
    g++\
    \
    repo \
    \
    openjdk-11-jdk \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 2
RUN useradd -m -s /bin/bash builder
USER builder

WORKDIR /home/builder

CMD ["/bin/bash"]
