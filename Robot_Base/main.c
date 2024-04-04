#include "../Common/Include/stm32l051xx.h"
#include <stdio.h>
#include <stdlib.h>
#include "../Common/Include/serial.h"
#include "adc.h"
#include "UART2.h"
#include "pwm.h"
#include "global.h"
#include "init.h"
#include "Period.h"
#include "sweep.h"
#include "main.h"

// LQFP32 pinout
//                 ----------
//           VDD -|1       32|- VSS
//          PC14 -|2       31|- BOOT0
//          PC15 -|3       30|- PB7 (OUT 5)
//          NRST -|4       29|- PB6 (OUT 4)
//          VDDA -|5       28|- PB5 (OUT 3)
//           PA0 -|6       27|- PB4 (OUT 2)
//           PA1 -|7       26|- PB3 (OUT 1)
//           PA2 -|8       25|- PA15
//           PA3 -|9       24|- PA14 (push button)
//           PA4 -|10      23|- PA13
//           PA5 -|11      22|- PA12 (pwm2)
//           PA6 -|12      21|- PA11 (pwm1)
//           PA7 -|13      20|- PA10 (Reserved for RXD)
// (ADC_IN8) PB0 -|14      19|- PA9  (Reserved for TXD)
// (ADC_IN9) PB1 -|15      18|- PA8  (Measure the period at this pin)
//           VSS -|16      17|- VDD
//                 ----------


int sweep=0;

void terribleSolution(void){
	sweep=0;
}



int main(void)
{
    char buff[80];
    int cnt=0;
    int red = 500;
    int reading;
    int frequency;
    int noMetal = 67500;
    int sending;
    int length;
    int width;


	Hardware_Init();
	initUART2(9600);
	
	waitms(1000); // Give putty some time to start.
	printf("\r\nJDY-40 test\r\n");

	// We should select an unique device ID.  The device ID can be a hex
	// number from 0x0000 to 0xFFFF.  In this case is set to 0xABBA
	SendATCommand("AT+DVID0901\r\n");  
	SendATCommand("AT+RFID0902\r\n");

	// To check configuration
	SendATCommand("AT+VER\r\n");
	SendATCommand("AT+BAUD\r\n");
	SendATCommand("AT+RFID\r\n");
	SendATCommand("AT+DVID\r\n");
	SendATCommand("AT+RFC\r\n");
	SendATCommand("AT+POWE\r\n");
	SendATCommand("AT+CLSS\r\n");
	
	printf("\r\nPress and hold a push-button attached to PA8 (pin 18) to transmit.\r\n");
	
	cnt=0;
	doneSetup();
	while(1)
	{
	
		if(ReceivedInt2()){
             reading=ReadInt2();
             if(reading/100 && sweep==0){
             	pwmPower1(reading);
             	}
             else if(sweep==0 && reading==99){
             	while(ReceivedInt2()==0);
             	reading=ReadInt2();
             	length=reading/10;
             	width=reading%10;
             	startSweep(length,width);
             	sweep=1;
             }
             	
             
             //printf("%d\n",reading);
             
             frequency=findPeriod();
             if(sweep)
             	frequency=frequency;	
             
             if(frequency-noMetal > 150 && frequency-noMetal < 2000)
             {
             	sending = (frequency-noMetal)/8;
             	eputnum2(sending);
             	if(sweep){
             		stopSweep();
             		sweep=0;
             		}
        	 }
        	 else if(frequency-noMetal < 150)
        	 {
        	 	sending = 0;
        	 	eputnum2(sending); //send zero if negligible metal
        	 }
        	 else if(frequency-noMetal > 2000)
        	 {
        	 	sending = 250;
        	 	eputnum2(sending); //send 250 so speaker will beep at max speed
        	 	if(sweep){
             		stopSweep();
             		sweep=0;
             		}
        	 }   
        }   
	}
}
