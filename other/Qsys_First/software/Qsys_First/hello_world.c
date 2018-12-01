/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>
#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "alt_types.h"
#include "sys/alt_irq.h"
alt_u8 LED_Toggle = 0;

static void KeyDown_interrupts(void* context,alt_u32 id)
{
	LED_Toggle=~LED_Toggle;
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIO_KEY_BASE,0x1);
	}

void Init_Interrupt(void)
{
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(PIO_KEY_BASE,0x1);
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIO_KEY_BASE,0x1);
	alt_irq_register(PIO_KEY_IRQ,NULL,KeyDown_interrupts);
}
int main()
{
  printf("Code Running...");
  Init_Interrupt();
  while(1)
  {IOWR_ALTERA_AVALON_PIO_DATA(PIO_LED_BASE,LED_Toggle);}

  return (0);
}
