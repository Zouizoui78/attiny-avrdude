#ifndef IO_H
#define IO_H 1

typedef volatile unsigned char* reg_t;

// Offset of the IO registers
// The datasheet gives registers addresses relative to this
#define IO_REG_OFFSET 0x20

// Pins direction register (input vs. output)
#define DDRB (reg_t)(IO_REG_OFFSET + 0x17)

// Output pins data register
#define PORTB (reg_t)(IO_REG_OFFSET + 0x18)

#endif
