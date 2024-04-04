#include <EFM8LB1.h>
#include "global.h"

char _c51_external_startup (void)
{
	// Disable Watchdog with 2-byte key sequence
	SFRPAGE = 0x00;
	WDTCN = 0xDE; //First key
	WDTCN = 0xAD; //Second key
	
	VDM0CN=0x80;	//enable VDD monitor
	RSTSRC=0x02|0x04;	//enable reset on missing clock detector and VDD

	#if (SYSCLK == 48000000L)	
		SFRPAGE = 0x10;
		PFE0CN  = 0x10; // SYSCLK < 50 MHz.
		SFRPAGE = 0x00;
	#elif (SYSCLK == 72000000L)
		SFRPAGE = 0x10;
		PFE0CN  = 0x20; // SYSCLK < 75 MHz.
		SFRPAGE = 0x00;
	#endif
	
	#if (SYSCLK == 12250000L)
		CLKSEL = 0x10;
		CLKSEL = 0x10;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 24500000L)
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 48000000L)	
		// Before setting clock to 48 MHz, must transition to 24.5 MHz first
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
		CLKSEL = 0x07;
		CLKSEL = 0x07;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 72000000L)
		// Before setting clock to 72 MHz, must transition to 24.5 MHz first
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
		CLKSEL = 0x03;
		CLKSEL = 0x03;
		while ((CLKSEL & 0x80) == 0);
	#else
		#error SYSCLK must be either 12250000L, 24500000L, 48000000L, or 72000000L
	#endif

	P0MDOUT |= 0x15; // Enable UART0 TX P0.4, P0.2, UART1 TX P0.0 as push-pull output
	P2MDOUT |= 0b_0001_0000; //speaker output at P2.4
	
	XBR0     = 0x01; // Enable UART0 on P0.4(TX) and P0.5(RX)                     
	XBR1     = 0X00;
	XBR2     = 0x41; // Enable crossbar and weak pull-ups and UART1

	#if (((SYSCLK/BAUDRATE)/2L)>0xFFL)
		#error Timer 0 reload value is incorrect because (SYSCLK/BAUDRATE) > 0xFF
	#endif
	
	//Configure TMR0
	
	TR0=0;
	TF0=0;
	CKCON0|=0b_0000_0100; //tmr 0 sysclock
	TMOD&=0xF0;
	TMOD|=0x01; //tmr0 in mode 1:16bit tmr
	
	TMR0=0x10000L-(SYSCLK/TIMER_0_FREQ);
	ET0=1;//tmr 0 interrrupts
	EA=1;
	
	
	
	
	// Configure Uart 0
	SCON0 = 0x10;
	CKCON0 |= 0b_0000_1000 ; // Timer 1 uses the system clock.
	TH1 = 0x100-((SYSCLK/BAUDRATE)/2L);
	TL1 = TH1;      // Init Timer1
	TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	TMOD |=  0x20;                       
	TR1 = 1; // START Timer1
	TI = 1;  // Indicate TX0 ready
	
	return 0;
}
