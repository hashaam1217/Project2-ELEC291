/////////////////////////////////////////////////////////////////////////////
// pwm_blinky.h
/////////////////////////////////////////////////////////////////////////////

#ifndef PWM_BLINKY_H_
#define PWM_BLINKY_H_

/////////////////////////////////////////////////////////////////////////////
// Includes
/////////////////////////////////////////////////////////////////////////////

#include "joystick.h"
#include "pwm_blinky_config.h"

/////////////////////////////////////////////////////////////////////////////
// Prototypes
/////////////////////////////////////////////////////////////////////////////

void PWM_Blinky_Init();
void PWM_Blinky_Update();

void PWM_Blinky_UpdateLED();

#endif /* PWM_BLINKY_H_ */
