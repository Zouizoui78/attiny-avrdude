#include "bit.h"
#include "interrupt.h"
#include "reg.h"

ISR(TIM1_OVF_VEC) {
    bit_toggle(PORTB, 1);
}

int main(void) {
    // Configure pin as output
    bit_set(DDRB, 1);

    // Set timer 1 prescaler to 16384
    *TCCR1 = 0b1111;

    // Enable timer 1 overflow interrupt
    bit_set(TIMSK, 2);

    // Enable interrupts
    sei();

    while (1) {}
}