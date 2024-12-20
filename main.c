#define F_CPU 8000000
#include <util/delay.h>

// Offset of the IO registers
// The datasheet gives registers addresses relative to this
#define IO_REG_OFFSET 0x20

// Pins direction register (input vs. output)
#define DDRB (*(volatile unsigned char *)(IO_REG_OFFSET + 0x17))

// Output pins data register
#define PORTB (*(volatile unsigned char *)(IO_REG_OFFSET + 0x18))

#define BIT_SET(__REG, __BIT) __REG |= 1 << __BIT
#define BIT_CLEAR(__REG, __BIT) __REG &= ~(1 << __BIT)

void main(void) {
    BIT_SET(DDRB, 4); // Set PB4 as output

    while (1) {
        BIT_SET(PORTB, 4); // Set PB4 high
        _delay_ms(1000);
        BIT_CLEAR(PORTB, 4); // Set PB4 low
        _delay_ms(1000);
    }
}
