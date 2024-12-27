#ifndef REG_H
#define REG_H 1

typedef volatile unsigned char *reg_t;

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
#define PB5 5
#define PB4 4
#define PB3 3
#define PB2 2
#define PB1 1
#define PB0 0

// I2C pins
#define SCK 2
#define SDA 0

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

// USI //

// USI data buffer
#define USIBR REG(0x10)

// USI data
#define USIDR REG(0x0F)

// USI status
#define USISR REG(0x0E)
#define USISIF 7  // Start Interrupt Flag
#define USIOIF 6  // Counter Overflow Interrupt Flag
#define USIPF 5   // Stop condition flag
#define USIDC 4   // Data output Collision
#define USICNT3 3 // Counter bit 3
#define USICNT2 2 // Counter bit 2
#define USICNT1 1 // Counter bit 1
#define USICNT0 0 // Counter bit 0

// USI control
#define USICR REG(0x0D)
#define USISIE 7 // Start condition Interrupt Enable
#define USIOIE 6 // Counter Overflow Interrupt Enable
#define USIWM1 5 // Wire Mode 1
#define USIWM0 4 // Wire Mode 0
#define USICS1 3 // Clock Select 1
#define USICS0 2 // Clock Select 0
#define USICLK 1 // Clock pin
#define USITC 0  // Toggle Clock

#endif
