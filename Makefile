CC=avr-gcc
OBJCOPY=avr-objcopy
AVRDUDE=avrdude
AVRSIZE=avr-size

INST_SET=attiny85
PROGRAMMER=usbtiny
TARGET=t85

RSTDISBL=1
DWEN=1
SPIEN=0
WDTON=1
EESAVE=1
BODLEVEL2=1
BODLEVEL1=1
BODLEVEL0=1
HFUSE=0b$(RSTDISBL)$(DWEN)$(SPIEN)$(WDTON)$(EESAVE)$(BODLEVEL2)$(BODLEVEL1)$(BODLEVEL0)

CKDIV8=1
CKOUT=1
SUT1=1
SUT0=0
CKSEL3=0
CKSEL2=0
CKSEL1=1
CKSEL0=0
LFUSE=0b$(CKDIV8)$(CKOUT)$(SUT1)$(SUT0)$(CKSEL3)$(CKSEL2)$(CKSEL1)$(CKSEL0)

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
	$(CC) -mmcu=$(INST_SET) $(CC_OPT) $< -o $@

$(ASM_DIR)/%.asm: $(SRC_DIR)/%.c
	@mkdir -p $(ASM_DIR)
	$(CC) -mmcu=$(INST_SET) $(CC_OPT) -S $< -o $@

# Include rules produced by -MMD -MP
-include $(DEPS)

$(HEX): $(OBJ)
	$(OBJCOPY) -O ihex -j.text -j.data $^ $@

asm: $(ASM)

flash: $(HEX)
	$(AVRDUDE_CMD) -U flash:w:$<:i

fuse:
	$(AVRDUDE_CMD) -U hfuse:w:$(HFUSE):m -U lfuse:w:$(LFUSE):m

fuser: FUSES=$(shell $(AVRDUDE_CMD) -qq -U hfuse:r:-:b -U lfuse:r:-:b)
fuser:
	@./scripts/fuses.sh $(FUSES)

size: $(HEX)
	@$(AVRSIZE) $<

clean:
	@rm -r build

PHONY: all asm flash fuse fuser size clean
