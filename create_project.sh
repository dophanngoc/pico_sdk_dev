#!/usr/bin/env bash

echo -n "Enter dir name to your project:"
read proj_name
mkdir -p $proj_name
cd $proj_name

if [ ! -f  CMakeLists.txt ]; then
   tee -a CMakeLists.txt > /dev/null << EOT
cmake_minimum_required(VERSION 3.13)

include(pico_sdk_import.cmake)

project($proj_name C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
pico_sdk_init()
add_executable($proj_name
        $proj_name.c
        )
pico_enable_stdio_usb($proj_name 1)
pico_enable_stdio_uart($proj_name 0)
target_link_libraries($proj_name pico_stdlib)

# create map/bin/hex file etc.
pico_add_extra_outputs($proj_name)

# add url via pico_set_program_url
target_link_libraries($proj_name pico_stdlib)
EOT
fi
touch $proj_name.c
cp ../pico-sdk/external/pico_sdk_import.cmake .

