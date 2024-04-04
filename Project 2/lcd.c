//  LCD in 4-bit interface mode
#include <EFM8LB1.h>
#include "lcd.h"
#include "global.h"
#include <stdio.h>
#include <stdlib.h>

// Uses Timer3 to delay <us> micro-seconds. 
void Timer3us(unsigned char us)
{
	unsigned char i;               // usec counter
	
	// The input for Timer 3 is selected as SYSCLK by setting T3ML (bit 6) of CKCON0:
	CKCON0|=0b_0100_0000;
	
	TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	
	TMR3CN0 = 0x04;                 // Sart Timer3 and clear overflow flag
	for (i = 0; i < us; i++)       // Count <us> overflows
	{
		while (!(TMR3CN0 & 0x80));  // Wait for overflow
		TMR3CN0 &= ~(0x80);         // Clear overflow indicator
	}
	TMR3CN0 = 0 ;                   // Stop Timer3 and clear overflow flag
}

void waitms (unsigned int ms)
{
	unsigned int j;
	unsigned char k;
	for(j=0; j<ms; j++)
		for (k=0; k<4; k++) Timer3us(250);
}

void LCD_pulse (void)
{
	LCD_E=1;
	Timer3us(40);
	LCD_E=0;
}

void LCD_byte (unsigned char x)
{
	// The accumulator in the C8051Fxxx is bit addressable!
	ACC=x; //Send high nible
	LCD_D7=ACC_7;
	LCD_D6=ACC_6;
	LCD_D5=ACC_5;
	LCD_D4=ACC_4;
	LCD_pulse();
	Timer3us(40);
	ACC=x; //Send low nible
	LCD_D7=ACC_3;
	LCD_D6=ACC_2;
	LCD_D5=ACC_1;
	LCD_D4=ACC_0;
	LCD_pulse();
}

void WriteData (unsigned char x)
{
	LCD_RS=1;
	LCD_byte(x);
	waitms(2);
}

void WriteCommand (unsigned char x)
{
	LCD_RS=0;
	LCD_byte(x);
	waitms(5);
}

void LCD_4BIT (void)
{
	LCD_E=0; // Resting state of LCD's enable is zero
	//LCD_RW=0; // We are only writing to the LCD in this program
	waitms(20);
	// First make sure the LCD is in 8-bit mode and then change to 4-bit mode
	WriteCommand(0x33);
	WriteCommand(0x33);
	WriteCommand(0x32); // Change to 4-bit mode

	// Configure the LCD
	WriteCommand(0x28);
	WriteCommand(0x0c);
	WriteCommand(0x01); // Clear screen command (takes some time)
	waitms(20); // Wait for clear screen command to finsih.
}

void LCDprint(char * string, unsigned char line, bit clear)
{
	int j;

	WriteCommand(line==2?0xc0:0x80);
	waitms(5);
	for(j=0; string[j]!=0; j++)	WriteData(string[j]);// Write the message
	if(clear) for(; j<CHARS_PER_LINE; j++) WriteData(' '); // Clear the rest of the line
}
void LCDprintNum(xdata double number, unsigned char line, int ind, int length, bit clear)
{
	int j;
	int lsel;

	xdata char buffs[50];
	sprintf(buffs, "%f", number);
	
	if(line==1)
		lsel=0x80+ind;
	else
		lsel=0xc0+ind;
	
	WriteCommand(lsel);
	waitms(5);
	for(j=0; j<length; j++)	WriteData(buffs[j]);// Write the message
	if(clear) for(; j<CHARS_PER_LINE; j++) WriteData(' '); // Clear the rest of the line
}

void printStrength(int metal)
{
	if(metal<=16)
		LCDprint("##               ",2,1);
	else if(metal>16 && metal<=32)
		LCDprint("###              ",2,1);
	else if(metal>32 && metal<=48)
		LCDprint("####             ",2,1);
	else if(metal>48 && metal<=64)
		LCDprint("#####            ",2,1);
	else if(metal>64 && metal<=80)
		LCDprint("######           ",2,1);
	else if(metal>80 && metal<=96)
		LCDprint("#######          ",2,1);
	else if(metal>96 && metal<=112)
		LCDprint("########         ",2,1);
	else if(metal>112 && metal<=128)
		LCDprint("#########        ",2,1);
	else if(metal>128 && metal<=144)
		LCDprint("##########       ",2,1);
	else if(metal>144 && metal<=160)
		LCDprint("###########      ",2,1);
	else if(metal>160 && metal<=176)
		LCDprint("############     ",2,1);
	else if(metal>176 && metal<=192)
		LCDprint("#############    ",2,1);
	else if(metal>192 && metal<=208)
		LCDprint("##############   ",2,1);
	else if(metal>208 && metal<=224)
		LCDprint("############### ",2,1);
	else
		LCDprint("################",2,1);
}