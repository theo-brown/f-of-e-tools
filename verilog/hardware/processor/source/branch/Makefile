TREEROOT	= /data/f-of-e-tools
REPOROOT = ~/f-of-e-tools

include $(TREEROOT)/tools/sunflower/conf/setup.conf

TARGET-ARCH	= riscv32-elf
TARGET		= riscv

PROGRAM		= branch
PROGRAM-SF	= branch-sf
INIT		= init
INIT-SF		= init-sf

COMPILED_PROGRAM_PATH = $(REPOROOT)/verilog/hardware/processor/programs

LIBOS-SF = mOS
TOOLSLIB-SF = $(TREEROOT)/tools/sunflower/tools/tools-lib/
INCLUDES-SF = -I$(TREEROOT)/tools/sunflower/tools/riscv/include -I$(TREEROOT)/tools/sunflower/benchmarks/source/port  -I$(TREEROOT)/tools/sunflower/sys/include -I$(TREEROOT)/tools/sunflower/sys/kern/superH -I$(TREEROOT)/tools/sunflower/benchmarks/include -I$(TREEROOT)/tools/sunflower/sys/libOS/port

OPTFLAGS	= -O0
CFLAGS          = -march=rv32i -mabi=ilp32 $(TARGET-ARCH-FLAGS) -Wall
ASFLAGS         = --march=rv32i --mabi=ilp32
LDFLAGS		= -L$(TOOLSLIB)/$(TARGET) -Map $(PROGRAM).map -Tsail.ld
LDFLAGS-SF	= -Ttext $(LOADADDR-SF)  -L$(TOOLSLIB-SF)/$(TARGET) -L$(TREEROOT)/tools/sunflower/sys/libOS/$(LIBOS-SF) -Map $(PROGRAM).map
SREC2HEX	= srec2hex
LOADADDR-SF	= 0x08004000

OBJS		=\
		$(INIT).o\
		$(PROGRAM).o\

OBJS-SF		=\
		$(INIT-SF).o\
		$(PROGRAM-SF).o\

all: sail sunflower

sail:	$(PROGRAM) $(PROGRAM).sr Makefile

$(INIT).o: $(INIT).S
	$(AS) $(ASFLAGS) $(INIT).S -o $(INIT).o

$(PROGRAM): $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) -o $@ -lc -lm -lgcc

$(PROGRAM).sr:$(PROGRAM)
	$(OBJCOPY) -O srec $(PROGRAM) $@

$(PROGRAM).o: $(PROGRAM).c Makefile
	$(CC) $(CFLAGS) $(OPTFLAGS) -c $(PROGRAM).c


sunflower: $(PROGRAM-SF) $(PROGRAM-SF).sr Makefile

$(PROGRAM-SF): $(OBJS-SF)
	$(LD) $(LDFLAGS-SF) $(OBJS-SF) -o $@ -lprintf -lc -lgcc -lgloss
	echo $(PREFIX)

$(PROGRAM-SF).sr: $(PROGRAM-SF)
	$(OBJCOPY) -O srec $(PROGRAM-SF) $@

$(PROGRAM-SF).o: $(PROGRAM-SF).c Makefile
	$(CC) $(CFLAGS) $(OPTFLAGS) $(INCLUDES-SF) -c $(PROGRAM-SF).c

$(INIT-SF).o: $(INIT-SF).S
	$(AS) $(ASFLAGS) $(INIT-SF).S -o $(INIT-SF).o


install: sail
	$(SREC2HEX) -b 4096 $(PROGRAM).sr
	cp program.hex $(COMPILED_PROGRAM_PATH)
	cp data.hex $(COMPILED_PROGRAM_PATH)

clean:
	$(RM) init.i *.o $(PROGRAM) $(PROGRAM).sr $(PROGRAM).map
	$(RM) init-sf.i *.o $(PROGRAM-SF) $(PROGRAM-SF).sr $(PROGRAM-SF).map
	$(RM) program.hex data.hex
