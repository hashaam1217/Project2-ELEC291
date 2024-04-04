#include "../Common/Include/stm32l051xx.h"
#include "global.h"
#include "init.h"

void Hardware_Init(void)
{
	GPIOA->OSPEEDR=0xffffffff; // All pins of port A configured for very high speed! Page 201 of RM0451

	RCC->IOPENR |= BIT0; // peripheral clock enable for port A

    GPIOA->MODER = (GPIOA->MODER & ~(BIT27|BIT26)) | BIT26; // Make pin PA13 output (page 200 of RM0451, two bits used to configure: bit0=1, bit1=0))
	GPIOA->ODR |= BIT13; // 'set' pin to 1 is normal operation mode.

	GPIOA->MODER &= ~(BIT16 | BIT17); // Make pin PA8 input
	// Activate pull up for pin PA8:
	GPIOA->PUPDR |= BIT16; 
	GPIOA->PUPDR &= ~(BIT17);
	
	//RCC->IOPENR |= 0x00000001; // peripheral clock enable for port A
	
	
	
	// Set up output port bit for blinking LED
//	RCC->IOPENR |= BIT0; // peripheral clock enable for port A
    GPIOA->MODER = (GPIOA->MODER & ~(BIT1)) | BIT0; // Make pin PA0 output (page 200 of RM0451, two bits used to configure: bit0=1, bit1=0)
	
	GPIOA->MODER = (GPIOA->MODER & ~(BIT3)) | BIT2; // Make pin PA1 output (page 200 of RM0451, two bits used to configure: bit2=1, bit3=0)
	
	GPIOA->MODER = (GPIOA->MODER & ~(BIT5)) | BIT4; // Make pin PA2 output (page 200 of RM0451, two bits used to configure: bit4=1, bit5=0)
	
	GPIOA->MODER = (GPIOA->MODER & ~(BIT7)) | BIT6; // Make pin PA3 output (page 200 of RM0451, two bits used to configure: bit6=1, bit7=0)
	
	GPIOA->MODER = (GPIOA->MODER & ~(BIT9)) | BIT8; //Make pin PA4 output
	
	// Configure PA15 for altenate function (TIM2_CH1, pin 25 in LQFP32 package)
	GPIOA->OSPEEDR  |= BIT30; // MEDIUM SPEED
	GPIOA->OTYPER   &= ~BIT15; // Push-pull
	GPIOA->MODER    = (GPIOA->MODER & ~(BIT30)) | BIT31; // AF-Mode
	
	//GPIOA->AFR[1]   |= BIT30 | BIT28 ; // AF5 selected (check table 16 in page 43 of "en.DM00108219.pdf")
	
	
	// Set up timer
	RCC->APB1ENR |= BIT0;  // turn on clock for timer2 (UM: page 177)
	TIM2->ARR = SYSCLK/TICK_FREQ;
	//TIM2->ARR = 255;
	NVIC->ISER[0] |= BIT15; // enable timer 2 interrupts in the NVIC
	TIM2->CR1 |= BIT4;      // Downcounting    
	TIM2->CR1 |= BIT7;      // ARPE enable    
	TIM2->DIER |= BIT0;     // enable update event (reload event) interrupt 
	TIM2->CR1 |= BIT0;      // enable counting    
	
	// Set up timer22
	RCC->APB2ENR |= BIT5;  // turn on clock for timer22
	TIM22->ARR = SYSCLK/TICK_FREQ;
	NVIC->ISER[0] |= BIT22; // enable timer 22 interrupts in the NVIC
	TIM22->CR1 |= BIT4;      // Downcounting    
	TIM22->CR1 |= BIT7;      // ARPE enable    
	TIM22->DIER |= BIT0;     // enable update event (reload event) interrupt 

/*	
	// Set up timer21
	RCC->APB2ENR |= BIT2;  // turn on clock for timer21
	TIM21->ARR = SYSCLK/TICK_FREQ;
	NVIC->ISER[0] |= BIT20; // enable timer 21 interrupts in the NVIC
	TIM21->CR1 |= BIT4;      // Downcounting    
	TIM21->CR1 |= BIT7;      // ARPE enable    
	TIM21->DIER |= BIT0;     // enable update event (reload event) interrupt 
*/	
	
	__enable_irq();
	
}