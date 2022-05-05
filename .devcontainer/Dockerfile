# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.224.3/containers/debian/.devcontainer/base.Dockerfile

# [Choice] Debian version (use bullseye on local arm64/Apple Silicon): bullseye, buster
ARG VARIANT="buster"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

RUN mkdir -p /home/vscode/.local/bin

# ** [Optional] Uncomment this section to install additional packages. **
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    automake \
    build-essential \
    bison \
    flex \
    git \
    gperf \
    libtinfo-dev \
    pkg-config \
    subversion \
    texinfo \
    tig \
    zip

WORKDIR /home/vscode/

RUN git clone --depth 1 --branch 7.3.0-atmel3.6.1-arduino7 https://github.com/arduino/toolchain-avr.git

WORKDIR /home/vscode/toolchain-avr/

RUN ./tools.bash && \
   ./binutils.build.bash

RUN ./gcc.build.bash

RUN ./avr-libc.build.bash

# RUN ./gdb.build.bash

# Installs bazelisk
RUN curl -fSsL -o /home/vscode/.local/bin/bazel "https://github.com/bazelbuild/bazelisk/releases/download/v1.11.0/bazelisk-linux-amd64" && \
    chmod u+x /home/vscode/.local/bin/bazel && \
    chown -R vscode:vscode /home/vscode/ 
