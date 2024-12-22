#ifndef REG_H
#define REG_H 1

typedef volatile unsigned char* reg_t;

// Offset of the CPU registers
// The datasheet gives registers addresses relative to this
#define REG_OFFSET 0x20

#define REG(address) (*(reg_t)(REG_OFFSET + address))


// Power reduction
#define PRR REG(0x20)
#define PRTIM1 3
#define PRTIM0 2
#define PRUSI 1
#define PRADC 0


// IO //

// Pins direction (input vs. output)
#define DDRB REG(0x17)
#define DDB5 5
#define DDB4 4
#define DDB3 3
#define DDB2 2
#define DDB1 1
#define DDB0 0

// Output pins data
#define PORTB REG(0x18)
#define PORTB5 5
#define PORTB4 4
#define PORTB3 3
#define PORTB2 2
#define PORTB1 1
#define PORTB0 0


// Interrupts //

// Timer interrupts mask
#define TIMSK REG(0x39)
#define OCIE1A 6
#define OCIE1B 5
#define OCIE0A 4
#define OCIE0B 3
#define TOIE1 2
#define TOIE0 1

// Timer 1 control
#define TCCR1 REG(0x30)
#define CTC1 7
#define PWM1A 6
#define COM1A1 5
#define COM1A0 4
#define CS13 3
#define CS12 2
#define CS11 1
#define CS10 0

#endif
