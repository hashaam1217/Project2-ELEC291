#include  "../Common/Include/stm32l051xx.h"
#include "../Common/Include/serial.h"
#include "pwm.h"

volatile int Count = 0;
volatile int pwmleft = 5;
volatile int pwmright = 5;
volatile int sideinput = 4;
volatile int forwardinput = 4;
//volatile int pwm3 = 1000;
//volatile int pwm4 = 1000;

void pwmPower1(int option){ 
	int leftdata = (option/10)%10;
	int rightdata = (option%100)%10;
	int sel = option/100;
	sideinput = leftdata;
	forwardinput = rightdata;
	switch (forwardinput)
	{
		case 0:
		case 8:
			if(sel==2)
				pwmleft=10; //180 deg turn for sweep
			else if(sideinput<=4)
				pwmleft=0; //on 100%
			else
				pwmleft=5;
		break;
		case 1:
		case 7:
			pwmleft=2; //on 75%
		break;
		case 2:
		case 6:
			pwmleft=5; //on 50%
		break;
		case 3:
		case 5:
			pwmleft=7; //on 25%
		break;
		default:
			if(sideinput!=4){
				pwmleft=0;   // on
			}
			else
			{
				pwmleft=10; // not on
			}
		break;
	}
	
	switch (forwardinput)
	{
		case 0:
		case 8:
			if(sel==3)
				pwmright=10; //180 deg for sweep
			else if(sideinput>=4 || sel==2)
				pwmright=0; //on 100%
			else
				pwmright=5;
		break;
		case 1:
		case 7:
			pwmright=2; //on 75%
		break;
		case 2:
		case 6:
			pwmright=5; //on 50%
		break;
		case 3:
		case 5:
			pwmright=7; //on 25%
		break;
		default:
			if(sideinput!=4)
			{
				pwmright=0; //on
			}
			else
			{
				pwmright=10;   //not on
			}
		break;
	}
}
/*
void pwmPower2(int option){ //forward wheel A
	switch (option)
	{
		case 6:
			pwm2=750; //on 25%
		break;
		case 7:
			pwm2=500; //on 50%
		break;
		case 8:
			pwm2=250; //on 75%
		break;
		case 9:
			pwm2=0; //on 100%
		break;
		default:
			pwm2=1000; //not on
		break;
	}
}

void pwmPower3(int option){ //backward wheel B
	switch (option)
	{
		case 1:
			pwm3=0; //on 100%
		break;
		case 2:
			pwm3=250; //on 75%
		break;
		case 3:
			pwm3=500; //on 50%
		break;
		case 4:
			pwm3=750; //on 25%
		break;
		default:
			pwm3=1000;   //not on
		break;
	}
}

void pwmPower4(int option){ //forward wheel B
	switch (option)
	{
		case 6:
			pwm4=750; //on 25%
		break;
		case 7:
			pwm4=500; //on 50%
		break;
		case 8:
			pwm4=250; //on 75%
		break;
		case 9:
			pwm4=0; //on 100%
		break;
		default:
			pwm4=1000; //not on
		break;
	}
}
*/

/*
void ToggleLED(void) 
{    
	GPIOA->ODR ^= BIT0; // Toggle PA0
}
void ToggleLED2(void) 
{    
	GPIOA->ODR ^= BIT1; // Toggle PA1
}

void ToggleLED3(void) 
{    
	GPIOA->ODR ^= BIT2; // Toggle PA2
}

void ToggleLED4(void) 
{    
	GPIOA->ODR ^= BIT3; // Toggle PA3
}
*/
void OneOn(void)
{
	GPIOA->ODR |= (1U << 0);
}

void TwoOn(void)
{
	GPIOA->ODR |= (1U << 1);
}

void ThreeOn(void)
{
	GPIOA->ODR |= (1U << 2);
}

void FourOn(void)
{
	GPIOA->ODR |= (1U << 3);
}

void OneOff(void)
{    
	GPIOA->ODR &= ~(1U << 0); // T
}

void TwoOff(void)
{    
	GPIOA->ODR &= ~(1U << 1); // T
}

void ThreeOff(void)
{    
	GPIOA->ODR &= ~(1U << 2); // T
}

void FourOff(void)
{    
	GPIOA->ODR &= ~(1U << 3); // T
}


void TIM2_Handler(void) 
{
 	TIM2->SR &= ~BIT0; // clear update interrupt flag
	Count++;
	
	OneOff();
	TwoOff();
	ThreeOff();
	FourOff();
	
	if (Count > pwmright) //For right wheel 
	{ 
		if(forwardinput>4) //backwards
		{
			TwoOff();
			OneOn();
		}
		else if (forwardinput<4) //forwards
		{
			OneOff();
			TwoOn();
		}
		else if (sideinput>4)  //left
		{
			OneOff();
			TwoOn();	
		}
		else if (sideinput<4) //right
		{
			TwoOff();
			OneOn();
		}
		else
		{
			OneOff();
			TwoOff();
		}
		
	}	
	
	if (Count > pwmleft) //For left wheel
	{ 
		if(forwardinput>4) //backwards
		{
			FourOff();
			ThreeOn();
		}
		else if (forwardinput<4) //forwards
		{
			ThreeOff();
			FourOn();
		}
		else if (sideinput>4)  //left
		{
			FourOff();
			ThreeOn();	
		}
		else if (sideinput<4)  //right
		{
			ThreeOff();
			FourOn();
		}
		else
		{
			ThreeOff();
			FourOff();
		}
	}	
	if (Count == 10) //Turning off all wheels
	{
		Count = 0;
		OneOff();
		TwoOff();
		ThreeOff();
		FourOff();
	}   
}
