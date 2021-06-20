FROM phusion/baseimage:focal-1.0.0-amd64

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    vim \
    tmux \
    git \
    gdb \
    sudo \
    strace \
    ltrace \
    python3 \
    python3-pip \
    python3-dev \
    ruby \
    ruby-dev \
    libssl-dev \
    libffi-dev \
    build-essential \
    patchelf

RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install --no-cache-dir \
    pwntools \
    ropgadget

RUN gem install one_gadget

RUN cd /root/ && \
    git clone --depth 1 https://github.com/pwndbg/pwndbg && \
    cd ./pwndbg && \
    ./setup.sh

CMD ["/sbin/my_init"]
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
