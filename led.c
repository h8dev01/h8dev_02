/*
 *	H8/3664F Sample Program
 *	Copyright (c) 2001 Masahiro Ochiai
 */

#include "3664.h"


#pragma interrupt
void int_timera(void)
{
	IRR1 &= ~0x60;

	PDR1 = ~PDR1;		/* Invert PDR1 */
}



int main()
{
	PMR1 = 0x00;
	PCR1 = 0xff;		/* Set Output Pin for P1x */
	PDR1 = 0x00;		/* Output 0 to P1x */

	TMA = 0x99;
	
	IENR1 |= 0x40;		/* Enable timer-A interrupt */

	STI();				/* CPU permit interrupts */

	while(1){
		SLEEP();
	}
}


