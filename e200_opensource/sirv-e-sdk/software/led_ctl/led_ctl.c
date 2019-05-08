#include <stdio.h>
#include <stdlib.h>
#include "platform.h"
#include <string.h>
#include "plic/plic_driver.h"
#include "encoding.h"
#include <unistd.h>
#include "stdatomic.h"

int main(){

	int DEFAULT_TR = 0x8000;
	int DEFAULT_TI = 0;

	int time = 0;
	int time_tmp;
	uint32_t leds = 0;
	asm volatile
	(
		"settr	%[r1]\n\t"
		"setti	%[r2]\n\t"
		:
		: [r1] "r" (DEFAULT_TR), [r2] "r" (DEFAULT_TI)
	);
	while (1) {

		// inside i-c-o
		// i
		time += 1;
		asm volatile
		(
			"tmove	%[r1]\n\t"
			"ttiat	%[r2], %[r3]\n\t"
			: [r2] "=r" (leds)
			: [r1] "r" (time), [r3] "r" (&GPIO_REG(GPIO_OUTPUT_VAL))
		);
		// c
		asm volatile
		(
			"getti	%[r1]\n\t"
			: [r1] "=r" (time_tmp)
			:
		);
		printf("It's %d trs, now.\n", time_tmp);
		// o
		time += 1;
		asm volatile
		(
			"tmove	%[r1]\n\t"
			"ttoat	%[r2], %[r3]\n\t"
			:
			: [r1] "r" (time), [r2] "r" (leds ^ ((0x1 << BLUE_LED_OFFSET))), [r3] "r" (&GPIO_REG(GPIO_OUTPUT_VAL))
		);
	}
	return 0;
}
