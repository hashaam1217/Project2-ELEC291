// PeriodEFM8.c: Measure the period of a signal on pin P0.1.
//
// By:  Jesus Calvino-Fraga (c) 2008-2018
//
// The next line clears the "C51 command line options:" field when compiling with CrossIDE
//  ~C51~

#include <EFM8LB1.h>
#include <stdio.h>
#include <stdint.h>

#define SYSCLK      72000000L  // SYSCLK frequency in Hz
#define BAUDRATE      115200L  // Baud rate of UART in bps

unsigned char overflow_count;

char _c51_external_startup (void)
{
	// Disable Watchdog with key sequence
	SFRPAGE = 0x00;
	WDTCN = 0xDE; //First key
	WDTCN = 0xAD; //Second key
 
	VDM0CN |= 0x80;
	RSTSRC = 0x02;

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
	
	P0MDOUT |= 0x10; // Enable UART0 TX as push-pull output
	XBR0     = 0x01; // Enable UART0 on P0.4(TX) and P0.5(RX)                     
	XBR1     = 0X00;
	XBR2     = 0x40; // Enable crossbar and weak pull-ups

	#if (((SYSCLK/BAUDRATE)/(2L*12L))>0xFFL)
		#error Timer 0 reload value is incorrect because (SYSCLK/BAUDRATE)/(2L*12L) > 0xFF
	#endif
	// Configure Uart 0
	SCON0 = 0x10;
	CKCON0 |= 0b_0000_0000 ; // Timer 1 uses the system clock divided by 12.
	TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L));
	TL1 = TH1;      // Init Timer1
	TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	TMOD |=  0x20;
	TR1 = 1; // START Timer1
	TI = 1;  // Indicate TX0 ready

	return 0;
}

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
	for(j=ms; j!=0; j--)
	{
		Timer3us(249);
		Timer3us(249);
		Timer3us(249);
		Timer3us(250);
	}
}

void TIMER0_Init(void)
{
	TMOD&=0b_1111_0000; // Set the bits of Timer/Counter 0 to zero
	TMOD|=0b_0000_0001; // Timer/Counter 0 used as a 16-bit timer
	TR0=0; // Stop Timer/Counter 0
}

void I2C_Init()
{
	//Configure SDA and SCL pins (setting them to push and pull mode)
	P2MDOUT |= 0x03; //Set P2.0 (SDA) and P2.1(SCL) as Push pull mode
	P2SKIP |= 0x03; // Skip Crossbar decoding for P2.0 and P2.1
	//Enable I2C0 peripheral
	I2C0CN0 |= 0x40; // Sets it as 01000000 

	// Setting clock rate for communication as 400KHz (Fast Mode)
	// To set in the normal mode I2C0CKR would have to be 359, which is too big for the register
	// Choosing between lowering the clock rate of the chip and increasing the rate of the I2C communication
	// Chose to increase clock rate
	SMB0CF = 0x59;
}

void I2C_Write(uint8_t addr, uint8_t data_input)
{
	/**
	 * SMB0CN0 Stands for System Management Bus Register
	 * SMB0CNO has 8 bits: Master, TXMODE, STA, STO, ACKRQ, ARBLOST, ACK, SI
	 * 					   [7]     [6]     [5]  [4]  [3]    [2]      [1]  [0]
	 * The SI (System Interrupt) is set when a transfer is completed
	 * Focusing on the higher for bits
	 * STA and STO are used to generate start and stop conditions
	 * TXMODE tells us whether we're transmitting or receiving
	 * Master tells us whether we're Master or slave
	 * More information is on page 310 on the manual document (Which is 394 pages)
	*/

	// Set start condition
	SMB0CN0 |= 0x20; //Sets SMB0CN0.5 (STA) to start an I2C transfer

    // Wait for transfer complete
    while (!(SMB0CN0 & 0x02));

    // Write address 
    SMB0DAT = addr;

    // Wait for transfer complete
    while (!(SMB0CN0 & 0x02)); //Waiting for SMB0CN0.0 (ACK) to indicate transfer complete

	// Write data
    SMB0DAT = data_input;

    // Wait for transfer complete
    while (!(SMB0CN0 & 0x02)); //Waiting for SMB0CN0.0 (ACK) to indicate transfer complete

    // Set stop condition
	SMB0CN0 |= 0x10;  //Sets SMB0CN0.4 (STO) to stop an I2C transfer
}

uint8_t I2C_Read(uint8_t addr)
{
    uint8_t data_output;

	// Set start condition
	SMB0CN0 |= 0x20; //Sets SMB0CN0.5 (STA) to start an I2C transfer

	printf("Transfer started");
	printf("SMB0CN0: %02X\n", SMB0CN0); //Waiting for SMB0CN0.0 (ACK) to indicate transfer complete
    // Wait for transfer complete
    while (!(SMB0CN0 & 0x02)); 
	//printf("%02X\n", SMB0CN0); //Waiting for SMB0CN0.0 (ACK) to indicate transfer complete
	printf("Transfer complete");

    // Write address with read bit set
    SMB0DAT = (addr << 1) | 1;

    // Wait for transfer complete
    while (!(SMB0CN0 & 0x02)); //Waiting for SMB0CN0.0 (ACK) to indicate transfer complete

    // Read data
    data_output = SMB0DAT;

    // Set stop condition
	SMB0CN0 |= 0x10;  //Sets SMB0CN0.4 (STO) to stop an I2C transfer

    return data_output;
}

void MPU6050_Init()
{
	I2C_Write(0x6B, 0x00);
}

void Test_I2C()
{
	uint8_t data_in = I2C_Read(0x75);
	if (data_in == 0x68)
	{
		printf("I2C is working correctly\n");
	}

	else 
	{
		printf("I2C is not working correctly: %u\n", data_in);
	}
}

void main (void) 
{
	//uint8_t data_storage;   
	SMB0CN0 |= 0x10;  //Sets SMB0CN0.4 (STO) to stop an I2C transfer

	waitms(500); // Give PuTTY a chance to start.
	printf("\x1b[2J"); // Clear screen using ANSI escape sequence.

	printf ("EFM8 Period measurement at pin P0.1 using Timer 0.\n"
	        "File: %s\n"
	        "Compiled: %s, %s\n\n",
	        __FILE__, __DATE__, __TIME__);

	I2C_Init();
	printf("Init Done\n");
	printf("%02X\n", SMB0CN0);
	SMB0CN0 &= ~0x10; // Clear SMB0CN0.4 (STO)
	printf("%02X\n", SMB0CN0);

	MPU6050_Init();

	printf("MPU6050 Init Done\n");


	Test_I2C();

	
	//data_storage = I2C_Read(0x68);
	//printf("Read Done\n");
	//printf("Data: %u\n", data_storage);

}
