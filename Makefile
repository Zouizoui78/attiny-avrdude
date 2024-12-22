CC=avr-gcc
OBJCOPY=avr-objcopy
AVRDUDE=avrdude
AVRSIZE=avr-size

INST_SET=attiny85
PROGRAMMER=usbtiny
TARGET=t85

CC_OPT=-Os
# Generate dependency files (.d) in objects dir
CC_OPT+=-MMD -MP
CC_WARN=-Wall

SRC_DIR=src
BUILD_DIR=build
OBJ_DIR=$(BUILD_DIR)/obj

HEXNAME=zouipocar.hex
HEX=$(BUILD_DIR)/$(HEXNAME)

SRC=$(wildcard $(SRC_DIR)/*.c)
OBJ=$(patsubst %.c, $(OBJ_DIR)/%.o, $(notdir $(SRC)))
DEPS=$(OBJ:.o=.d)

AVRDUDE_CMD=$(AVRDUDE) -c $(PROGRAMMER) -p $(TARGET)

all: $(HEX)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@# $< name of the first dependency
	@mkdir -p $(OBJ_DIR)
	$(CC) -mmcu=$(INST_SET) $(CC_OPT) $(CC_WARN) $< -o $@

# Include rules produced by -MMD -MP
-include $(DEPS)

$(HEX): $(OBJ)
	@# $^ name of all the target's dependencies
	@# $@ name of the target
	$(OBJCOPY) -O ihex -j.text -j.data $^ $@

asm:
	$(CC) -S -mmcu=$(INST_SET) $(CC_OPT) main.c -o main.asm

flash: $(HEX)
	$(AVRDUDE_CMD) -U flash:w:$<:i

fuseb:
	$(AVRDUDE_CMD) -U hfuse:r:-:b -U lfuse:r:-:b

fuseh:
	$(AVRDUDE_CMD) -U hfuse:r:-:h -U lfuse:r:-:h

size: $(HEX)
	$(AVRSIZE) $<

clean:
	@rm -r build

PHONY: all asm flash fuseb fuseh size clean
