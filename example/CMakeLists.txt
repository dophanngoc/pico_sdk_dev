cmake_minimum_required(VERSION 3.13)

include(pico_sdk_import.cmake)

project(light_sw C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
pico_sdk_init()
add_executable(light_sw
        light_sw.c
        )
pico_enable_stdio_usb(light_sw 1)
pico_enable_stdio_uart(light_sw 0)
target_link_libraries(light_sw pico_stdlib hardware_adc)

# create map/bin/hex file etc.
pico_add_extra_outputs(light_sw)

# add url via pico_set_program_url
target_link_libraries(light_sw pico_stdlib)
