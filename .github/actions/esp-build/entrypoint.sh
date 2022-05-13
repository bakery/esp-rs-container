#!/bin/sh -l

echo "hello $1"
ls / -al
/home/esp/export-rust.sh
env
/home/esp/.cargo/bin/rustup toolchain list
# rustup toolchain list
