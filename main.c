#define F_CPU 8000000
#include <util/delay.h>

#include "bit.h"
#include "io.h"

void main(void) {
    bit_set(DDRB, 1); // Set pin as output

    while (1) {
        bit_toggle(PORTB, 1);
        _delay_ms(1000);
    }
}
