#ifndef BIT_H
#define BIT_H 1

#include "reg.h" // For reg_t

typedef unsigned char bit_t;

static inline void bit_set(reg_t reg, bit_t bit) {
    *reg |= (1 << bit);
}

static inline void bit_clear(reg_t reg, bit_t bit) {
    *reg &= ~(1 << bit);
}

static inline void bit_toggle(reg_t reg, bit_t bit) {
    *reg ^= (1 << bit);
}

#endif
