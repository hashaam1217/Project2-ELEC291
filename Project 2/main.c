#include <EFM8LB1.h>
#include <stdio.h>
#include "lcd.h"
#include "jdy40.h"
#include "ADC.h"
#include "Speaker.h"

void main (void)
{
	
	int controlsum;
	int controls[3];
	char buff[17];
	int metalStrength;
	int menu = 0;
	int mode = 0; //0->standard, 1->sweep, 2->return home
	int settings = 0;
	int length = 1;
	int width = 1;
	int sweepsend;
	int returnmode;
	// Configure the LCD
	LCD_4BIT();

    UART1_Init(9600);


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

    printf("\r\Press and hold the BOOT button to transmit.\r\n");
	
   	// Display something in the LCD
	LCDprint("Metal Detecting  ", 1, 1);
	//LCDprint("¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦", 1, 1);
	LCDprint("    Robot!!      ", 2, 1);
	

    InitPinADC(2, 2); // Configure P2.2 as analog input
    InitPinADC(2, 3); // Configure P2.3 as analog input
    InitADC();
    //SpeakerStart(4);
	while(1)
	{
		controls[0]=ADC_at_Pin(QFP32_MUX_P2_2)/1821;
	    controls[1]=ADC_at_Pin(QFP32_MUX_P2_3)/1821;
	    controls[2]=P2_1;
	    
	    controlsum=controls[2]*100+controls[1]*10+controls[0];
		
		
		if(P2_5==0) // ENTER MODE SELECT MENU
		{
			waitms(50); 
			if(P2_5==0)
			{
				while(P2_5==0);
				
				LCDprint("Mode Select          ", 1, 1);
				LCDprint("Standard             ", 2, 1);
				menu=1;
				
				while(menu==1)	//LOOP HERE UNTIL CONFIRM PRESSED
				{
					if(P2_5==0)
					{
						while(P2_5==0);	
						if(mode==0)
						{
							mode=1;
							LCDprint("Sweep Mode             ", 2, 1);
						}
						else if(mode==1)
						{
							mode=2;
							LCDprint("Return to Home        ", 2, 1);
						}
						else
						{
							mode=0;
							LCDprint("Standard Mode         ", 2, 1);
						}
										
					}
					
					if(P3_0==0) // check if pressed CONFIRM BUTTON
					{
						if(P3_0==0)
						{
							while(P3_0==0);
							
							menu=0;//EXIT MODE SELECT
							
						}
					}	
				}///
			}
		}///
           	
		if(mode==0) //Normal Mode
		{
			
			if(returnmode==1 && P3_0==0)//signal to return home(if entered return mode)
			{
				LCDprint("Returning home", 1, 1);
				
				while(P3_0==0);
				
				putnum1(97); //signal to start returning home
				returnmode=0; //back to normal mode, just returning home
			}
	         
	         	putnum1(controlsum);
	            putchar('.');
	           
	            waitms_or_RI1(200);
	    
	        if(RXU1())
	        {
	            	
	           	metalStrength = getnum1();
	            		
	           	if(metalStrength == 0){
	           		SpeakerStop();
	           		LCDprint("   No Metal     ", 1, 1);
	           		LCDprint("  Detected!!    ", 2, 1);
	           	}
	           	else
	           	{
	           		LCDprint("Metal Strength", 1, 1);
	           		//LCDprint("Strength: ", 2, 1);
	           		printStrength(metalStrength);
	           		
	           		if(metalStrength <= 25)
	           		{	
	           			SpeakerStart(5);
	           			//LCDprintNum(metalStrength, 2, 10, 3, 1);
	           		}
	           		else if(metalStrength > 25 && metalStrength <= 50)
	           		{
	           			SpeakerStart(4);
	           			//LCDprintNum(metalStrength, 2, 10, 3, 1);
	           		}
	           		else if(metalStrength > 50 && metalStrength <= 75)
	           		{
	           			SpeakerStart(3);
	           			//LCDprintNum(metalStrength, 2, 10, 3, 1);
	           		}
	           		else if(metalStrength > 75 && metalStrength <= 150)
	           		{
	           			SpeakerStart(2);
	           			//LCDprintNum(metalStrength, 2, 10, 3, 1);
	           		}
	           		else if(metalStrength > 150)
	           		{
	           			SpeakerStart(1);
	           			//LCDprintNum(metalStrength, 2, 10, 3, 1);
	           		}
	           	}
	            //printf("%d\n",getnum1());         
	        }
		}
		else if(mode==1)	//Sweep Mode
		{
			LCDprint("Length     Width", 1, 1);
			LCDprint("                ", 2, 1);
			LCDprintNum(length, 2, 1, 1, 1);
			LCDprintNum(width, 2, 12, 1, 1);
			
			putnum1(99);
			putchar('.');
			settings=0;
			
						
			while(settings==0)
			{
				if(P2_6==0)
				{
					while(P2_6==0);	
					if(length==9)
					{
						length=1;	
					}
					else
					{
						length++;
					}
					LCDprintNum(length, 2, 1, 1, 1);
					LCDprintNum(width, 2, 12, 1, 1);					
				}
				if(P2_5==0)
				{
					while(P2_5==0);	
					if(width==9)
					{
						width=1;
						
					}
					else
					{
						width++;
					}
					LCDprintNum(width, 2, 12, 1, 1);					
				}
				if(P3_0==0)
				{
					while(P3_0==0);	
					settings=1;
					mode=0;
					sweepsend=10*length+width;
					putnum1(sweepsend);			
				}
			
		    }
		}
		else
		{
			LCDprint("In return home   ", 1, 1);
			
			putnum1(98);
			
			returnmode=1; //turn return mode on
		
			while(ADC_at_Pin(QFP32_MUX_P2_2)/1821==4 && ADC_at_Pin(QFP32_MUX_P2_3)/1821==4);
			
			mode=0;
			
		}
		
	}
}