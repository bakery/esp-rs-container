ARG VARIANT=bullseye
FROM debian:${VARIANT}
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN apt-get update \
    && apt-get install -y vim nano git curl gcc ninja-build cmake libudev-dev \
     python3 python3-pip libusb-1.0-0 libssl-dev pkg-config libtinfo5 clang \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts
RUN adduser --disabled-password --gecos "" vscode
USER vscode
WORKDIR /home/vscode
# Required due to: https://github.com/rust-lang/rust/issues/95267
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- \
    --default-toolchain nightly-2022-03-10 -y
ENV PATH=${PATH}:$HOME/.cargo/bin:$HOME/.cargo/bin
RUN $HOME/.cargo/bin/rustup component add rust-src --toolchain nightly-2022-03-10
RUN $HOME/.cargo/bin/rustup target add riscv32i-unknown-none-elf
RUN $HOME/.cargo/bin/install cargo-generate cargo-espflash espmonitor bindgen ldproxy