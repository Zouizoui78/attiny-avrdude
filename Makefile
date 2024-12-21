CC=avr-gcc
OBJCOPY=avr-objcopy

INST_SET=attiny85
PROGRAMMER=usbtiny
TARGET=t85

AVRDUDE_CMD=avrdude -c $(PROGRAMMER) -p $(TARGET)

compile:
	$(CC) -Os -mmcu=$(INST_SET) -Wall main.c -o main.o

hex: compile
	$(OBJCOPY) -O ihex -j.text -j.data main.o main.hex

asm:
	$(CC) -S -Os -mmcu=$(INST_SET) -Wall main.c -o main.asm

flash: hex
	$(AVRDUDE_CMD) -U flash:w:main.hex:i

fuses:
	$(AVRDUDE_CMD) -U hfuse:r:-:b -U lfuse:r:-:b
