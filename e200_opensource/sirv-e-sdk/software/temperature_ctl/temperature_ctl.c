#include <stdio.h>

int main(){

	int DEFAULT_TR = 1000;
	int DEFAULT_TI = 0;
	int WANTED_TE = 20;

	int sim_in_port = 25;
	int sim_out_port = 0;

	int time = 0;
	int time_tmp;
	int input_buffer = 0;
	int output_buffer = 0;
	asm volatile
	(
		"settr	%[r1]\n\t"
		"setti	%[r2]\n\t"
		:
		: [r1] "r" (DEFAULT_TR), [r2] "r" (DEFAULT_TI)
	);
	while (1) {

		// sim outside enviroment
		if (1 == sim_out_port) {
			sim_in_port -= 1;
		} else if (2 == sim_out_port) {
			sim_in_port += 1;
		} else {
		}
		printf("It's %d C, now.\n", sim_in_port);

		// inside i-c-o
		// i
		time += 20;
		asm volatile
		(
			"tmove	%[r1]\n\t"
			"ttiat	%[r2], %[r3]\n\t"
			: [r2] "=r" (input_buffer)
			: [r1] "r" (time), [r3] "r" (&sim_in_port)
		);
		// c
		asm volatile
		(
			"getti	%[r1]\n\t"
			: [r1] "=r" (time_tmp)
			:
		);
		printf("It's %d trs, now.\n", time_tmp);
		if (WANTED_TE > input_buffer) {
			output_buffer = 2;
			printf("Outside temporature is lower, turn up.\n");
		} else if (WANTED_TE < input_buffer) {
			output_buffer = 1;
			printf("Outside temporature is higher, turn down.\n");
		}
		// o
		time += 20;
		asm volatile
		(
			"tmove	%[r1]\n\t"
			"ttoat	%[r2], %[r3]\n\t"
			:
			: [r1] "r" (time), [r2] "r" (output_buffer), [r3] "r" (&sim_out_port)
		);
	}
	return 0;
}
