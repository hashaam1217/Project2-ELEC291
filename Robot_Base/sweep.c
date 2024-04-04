#include  "../Common/Include/stm32l051xx.h"
#include "pwm.h"
#include "main.h"

volatile int secondsPassed=0;
volatile int ms=0;
volatile int x=1;
volatile int y=2;
volatile int count=0;
volatile int flag=1;

void startSweep(int length,int width){

	TIM22->CR1 |= BIT0;
	secondsPassed=0;
	ms=0;
	flag=1;
	x=length;
	y=width;
}

void stopSweep(void){

	TIM22->CR1 &= ~BIT0;
	TIM22->SR &= ~BIT0;
	secondsPassed=0;
	ms=0;
	count=0;
	flag=1;

}


void TIM22_Handler(void) 
{
	TIM22->SR &= ~BIT0; // clear update interrupt flag
	ms++;
	if(ms>999){
		ms=0;
		secondsPassed++;
	}
	
	if(count<y){
		if(secondsPassed<x&&flag)
			pwmPower1(40);
		else if(secondsPassed<(x+2)&& flag)
			pwmPower1(300);
		else if(secondsPassed<(x+3) && ms<299 && flag)
			pwmPower1(300);
		else if(flag){
			pwmPower1(44);
			flag=0;
			secondsPassed=0;
			ms=0;
			}
		else if(secondsPassed<x)
			pwmPower1(40);
		else if(secondsPassed<(x+2))
			pwmPower1(200);
		else if(secondsPassed<(x+3) && ms<299)
			pwmPower1(200);
		else{
			pwmPower1(44);
			count++;
			secondsPassed=0;
			ms=0;
			flag=1;
		}
	}
	else{
		stopSweep();
		terribleSolution();
		}
		
}