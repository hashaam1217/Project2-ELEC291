CC=arm-none-eabi-gcc
AS=arm-none-eabi-as
LD=arm-none-eabi-ld
CCFLAGS=-mcpu=cortex-m0 -mthumb -g 

LIBPATH1=$(shell dirname $(shell find /usr -name "libgcc.a" | grep "v6-m"))
LIBPATH2=$(shell dirname $(shell find /usr -name "libc_nano.a" | grep "v6-m"))
LIBSPEC=-L$(LIBPATH1) -L$(LIBPATH2)

OBJS=main.o serial.o UART2.o startup.o newlib_stubs.o

PORTN=$(shell cat COMPORT.inc)

main.elf : $(OBJS)
	$(LD) $(OBJS) $(LIBSPEC) -Os -nostdlib -lnosys -lgcc -T ../Common/LDscripts/stm32l051xx.ld --cref -Map main.map -o main.elf
	arm-none-eabi-objcopy -O ihex main.elf main.hex
	@echo Success!

main.o: main.c
	$(CC) -c $(CCFLAGS) main.c -o main.o

startup.o: ../Common/Source/startup.c
	$(CC) -c $(CCFLAGS) -DUSE_USART1 ../Common/Source/startup.c -o startup.o

serial.o: ../Common/Source/serial.c
	$(CC) -c $(CCFLAGS) ../Common/Source/serial.c -o serial.o

UART2.o: UART2.c
	$(CC) -c $(CCFLAGS) UART2.c -o UART2.o

newlib_stubs.o: ../Common/Source/newlib_stubs.c
	$(CC) -c $(CCFLAGS) ../Common/Source/newlib_stubs.c -o newlib_stubs.o

clean: 
	@rm -f $(OBJS) main.elf main.hex main.map *.lst

Flash_Load:
	echo "../stm32flash/stm32flash -w main.hex -v -g 0x0 > sflash.bat"
	../stm32flash/stm32flash -w main.hex -v -g 0x0 /dev/USB0

putty:
	@echo "cmd /c start putty.exe -sercfg 115200,8,n,1,N -serial > sputty.bat"
	@../stm32flash/BO230/BO230 -r >> sputty.bat
	@./sputty

explorer:
	@nautilus .


