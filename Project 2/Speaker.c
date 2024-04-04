#include <EFM8LB1.h>
#include "global.h"

xdata volatile unsigned int TickCount=0;
xdata volatile unsigned long int RunCount=0;
xdata volatile long unsigned int frequency;
xdata volatile long unsigned int per;

void SpeakerStart(int per){ //change to received
	
	//per = received / 52;	//As per increases, beeps get less frequent
	
	switch (per)
	        {
				case 1: // Ramp
					frequency=100;
				break;
				case 2: // Ramp
					frequency=200;
				break;
				case 3:
					frequency=300;
				break;
				case 4:
					frequency=500;
				break;
				case 5:
					frequency=750;
				break;
				case 6:
					frequency=1000;
				break;
				case 7:
					frequency=1500;
				break;
				case 8:
					frequency=3000;
				case 9:
					frequency=10000;
				break;
				default:
					frequency=0;
				break;
			}
		TR0=1;
}

void SpeakerStop(void){
	TR0=0;
}

void Timer0_ISR (void) interrupt INTERRUPT_TIMER0
{
	SFRPAGE=0x0;
	// Timer 0 in 16-bit mode doesn't have auto reload, so reload here
	TMR0=0x10000L-(SYSCLK/(TIMER_0_FREQ));
	
	RunCount++;
	
	if(RunCount<frequency)//adjust this to change frequency of beeps
	{
		TickCount++;
		if(TickCount==5){
			TickCount=0;
			P2_4=!P2_4; // Toggle P2_4 (where the LED is)
			}
	}else if(RunCount<frequency*2){
	}else{
		RunCount=0;
	}

}