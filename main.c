// Offset of the IO registers
#define IO_OFFSET 0x20

// Pins direction register (input vs. output)
#define DDRB (*(volatile unsigned char *)(IO_OFFSET + 0x17))

// Output pins data register
#define PORTB (*(volatile unsigned char *)(IO_OFFSET + 0x18))

#define BIT_SET(__REG, __BIT) __REG |= 1 << __BIT
#define BIT_CLEAR(__REG, __BIT) __REG &= ~(1 << __BIT)

int main() {
    BIT_SET(DDRB, 1);
    BIT_SET(PORTB, 4);
}
