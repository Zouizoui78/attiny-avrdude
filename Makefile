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
CC_OPT+=-Wall

SRC_DIR=src
BUILD_DIR=build
OBJ_DIR=$(BUILD_DIR)/obj
ASM_DIR=$(BUILD_DIR)/asm

HEXNAME=zouipocar.hex
HEX=$(BUILD_DIR)/$(HEXNAME)

SRC=$(wildcard $(SRC_DIR)/*.c)
OBJ=$(patsubst %.c, $(OBJ_DIR)/%.o, $(notdir $(SRC)))
ASM=$(patsubst %.c, $(ASM_DIR)/%.asm, $(notdir $(SRC)))
DEPS=$(OBJ:.o=.d)

AVRDUDE_CMD=$(AVRDUDE) -c $(PROGRAMMER) -p $(TARGET)

all: $(HEX)

# $< name of the first dependency
# $^ name of all the target's dependencies
# $@ name of the target

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	@$(CC) -mmcu=$(INST_SET) $(CC_OPT) $< -o $@

$(ASM_DIR)/%.asm: $(SRC_DIR)/%.c
	@mkdir -p $(ASM_DIR)
	@$(CC) -mmcu=$(INST_SET) $(CC_OPT) -S $< -o $@

# Include rules produced by -MMD -MP
-include $(DEPS)

$(HEX): $(OBJ)
	@$(OBJCOPY) -O ihex -j.text -j.data $^ $@

asm: $(ASM)

flash: $(HEX)
	@$(AVRDUDE_CMD) -U flash:w:$<:i

fuses: FUSES=$(shell $(AVRDUDE_CMD) -qq -U hfuse:r:-:b -U lfuse:r:-:b)
fuses:
	@./scripts/fuses.sh $(FUSES)

fusesh:
	@$(AVRDUDE_CMD) -qq -U hfuse:r:-:h -U lfuse:r:-:h

size: $(HEX)
	@$(AVRSIZE) $<

clean:
	@rm -r build

PHONY: all asm flash fuses fusesh size clean
