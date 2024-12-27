#ifndef BIT_H
#define BIT_H 1

#include "reg.h" // For reg_t

typedef unsigned char bit_t;

#define bv(shift) (1 << shift)

#define bit_set(reg, bit) reg |= (1 << bit)
#define bit_clear(reg, bit) reg &= ~(1 << bit)
#define bit_toggle(reg, bit) reg ^= (1 << bit)
#define bit_read(reg, bit) reg & (1 << bit)

#endif
