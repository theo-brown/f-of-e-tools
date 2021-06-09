TREEROOT	= /data/f-of-e-tools
REPOROOT = ~/f-of-e-tools

include $(TREEROOT)/tools/sunflower/conf/setup.conf

TARGET-ARCH	= riscv32-elf
TARGET		= riscv

PROGRAM		= factorise
INIT		= init

COMPILED_PROGRAM_PATH = $(REPOROOT)/verilog/hardware/processor2/programs

OPTFLAGS	= -O0
CFLAGS          = -march=rv32i -mabi=ilp32 $(TARGET-ARCH-FLAGS) -Wall
ASFLAGS         = --march=rv32i --mabi=ilp32
LDFLAGS		= -L$(TOOLSLIB)/$(TARGET) -Map $(PROGRAM).map -Tsail.ld
SREC2HEX	= srec2hex

OBJS		=\
		$(INIT).o\
		$(PROGRAM).o\

sail:	$(PROGRAM) $(PROGRAM).sr Makefile

$(INIT).o: $(INIT).S
	$(AS) $(ASFLAGS) $(INIT).S -o $(INIT).o

$(PROGRAM): $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) -o $@ -lc -lm -lgcc

$(PROGRAM).sr:$(PROGRAM)
	$(OBJCOPY) -O srec $(PROGRAM) $@

$(PROGRAM).o: $(PROGRAM).c Makefile
	$(CC) $(CFLAGS) $(OPTFLAGS) -c $(PROGRAM).c

install: sail
	$(SREC2HEX) -b 4096 $(PROGRAM).sr
	cp program.hex $(COMPILED_PROGRAM_PATH)
	cp data.hex $(COMPILED_PROGRAM_PATH)

clean:
	$(RM) init.i *.o $(PROGRAM) $(PROGRAM).sr $(PROGRAM).map
	$(RM) program.hex data.hex
