#### Run script
##### Prerequisite

- Rasp P3 or Rasp P4 or any Linux Computer board that supports arm SWD debug
- Connect Pico microUSB interface to the Linux Computer Board
- Prepare SWD debug wiring

For example:

| Rasp P3/P4      | Rasp Pico    |
|-----------------|--------------|
| GND(Pin 20      | SWD GND      |
| GPIO24(Pin 18)  | SWDIO        |
| GPIO25(Pin 22)  | SWCLK        | 

- Run:
 `$./bootstrap.sh`

##### Create new project
- Run:
 `$./create_project.sh`


#### Debug with SWD

- Run:

```
$cd <project_name>
$mkdir build
$cd build
$export PICO_SDK_PATH=../../pico-sdk
$cmake -DCMAKE_BUILD_TYPE=Debug ..
$cd hello_world
$make -j4

```

- Use GDB and OpenOCD to debug 

Open micro USB output
 `minicom -b 115200 -o -D /dev/ttyACM0`

attach OpenOCD to the chip
 `openocd -f interface/raspberrypi-swd.cfg -f target/rp2040.cfg`

attach a GDB instance to OpenOCD

```
gdb-multiarch <project_name>.elf
(gdb) target remote localhost:3333
(gdb) load
(gdb) monitor reset init
(gdb) continue
```

if you want to set a breakpoint at main() before running the executable,

```
(gdb) monitor reset init
(gdb) b main
(gdb) continue
(gdb) continue
```
For more infos, please visit GDB page.

*Note* 

To use _printf_ for debug messages, you need to enable either USB interface or UART interface to monitor the output.

```
$vi CMakeLists.txt

pico_enable_stdio_usb(<project_name> 1) #enable usb 
pico_enable_stdio_uart(<project_name> 0) #disable uart 
```

