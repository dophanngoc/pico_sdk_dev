#!/usr/bin/env bash

sudo apt update
sudo apt install cmake minicom gcc-arm-none-eabi libnewlib-arm-none-eabi build-essential
l \
automake autoconf build-essential texinfo libtool libftdi-dev libusb-1.0-0-
dev gdb-multiarch

cd ~/
mkdir pico
cd pico

git clone -b master https://github.com/raspberrypi/pico-sdk.git
cd pico-sdk
git submodule update --init

cd ..
git clone -b master https://github.com/raspberrypi/pico-examples.git

git clone https://github.com/raspberrypi/openocd.git --recursive --branch rp2040 --depth=1
cd openocd

./bootstrap
/configure --enable-ftdi --enable-sysfsgpio --enable-bcm2835gpio

make -j4
sudo make install


