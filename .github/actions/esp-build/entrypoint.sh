#!/bin/sh -l

echo "hello $1"
ls / -al
env
/home/esp/.cargo/bin/rustup toolchain list
# rustup toolchain list
