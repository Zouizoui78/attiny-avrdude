compile:
	avr-gcc -Os -mmcu=attiny85 -Wall main.c -o main.o

hex: compile
	avr-objcopy -O ihex -j.text -j.data main.o main.hex

asm:
	avr-gcc -S -Os -mmcu=attiny85 -Wall main.c -o main.asm

flash: hex
	avrdude -c usbtiny -p t85 -U flash:w:main.hex:i

