#ifndef REG_H
#define REG_H 1

typedef volatile unsigned char* reg_t;

// Offset of the CPU registers
// The datasheet gives registers addresses relative to this
#define REG_OFFSET 0x20

#define REG(address) (reg_t)(REG_OFFSET + address)


// Status register
#define SREG REG(0x3F)


// IO //

// Pins direction (input vs. output)
#define DDRB REG(0x17)

// Output pins data
#define PORTB REG(0x18)


// Interrupts //

// Timer interrupts mask
#define TIMSK REG(0x39)

// Timer 1 control
#define TCCR1 REG(0x30)

#endif
