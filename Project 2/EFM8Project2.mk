SHELL=cmd
CC=c51
COMPORT = $(shell type COMPORT.inc)
OBJS=main.obj startup.obj lcd.obj jdy40.obj ADC.obj Speaker.obj

main.hex: $(OBJS)
	$(CC) $(OBJS)
	@del *.asm *.lst *.lkr 2> nul
	@echo Done!
	
main.obj: main.c lcd.h jdy40.h ADC.h global.h Speaker.h
	$(CC) -c main.c

startup.obj: startup.c global.h
	$(CC) -c startup.c

lcd.obj: lcd.c lcd.h global.h
	$(CC) -c lcd.c
	
jdy40.obj: jdy40.c jdy40.h lcd.h global.h
	$(CC) -c jdy40.c

ADC.obj: ADC.c ADC.h lcd.h global.h
	$(CC) -c ADC.c

Speaker.obj: Speaker.c global.h Speaker.h
	$(CC) -c Speaker.c

clean:
	@del $(OBJS) *.asm *.lkr *.lst *.map *.hex *.map 2> nul

LoadFlash:
	@Taskkill /IM putty.exe /F 2>NUL | wait 500
	EFM8_prog -ft230 -r main.hex

Dummy: main.hex main.Map
	@echo Nothing to see here!
	
explorer:
	cmd /c start explorer .
		