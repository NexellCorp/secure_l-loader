CROSS_COMPILE=arm-linux-gnueabihf-
CC=$(CROSS_COMPILE)gcc
LD=$(CROSS_COMPILE)ld
AS=$(CROSS_COMPILE)gcc
OBJCOPY=$(CROSS_COMPILE)objcopy
BL1=bl1.bin

all: l-loader.bin ptable.img

ifneq (${PLAT_DRAM_SIZE},)
CFLAGS			+=	-DPLAT_DRAM_SIZE=${PLAT_DRAM_SIZE}
PVFLAGS			+=	-DPLAT_DRAM_SIZE=${PLAT_DRAM_SIZE}
ifeq (${PLAT_DRAM_SIZE},2048)
TEXT_BASE=0xbfe00800
else ifeq (${PLAT_DRAM_SIZE},512)
TEXT_BASE=0x5fe00800
else
TEXT_BASE=0x7fe00800
endif

else
CFLAGS			+=	-DPLAT_DRAM_SIZE=1024
PVFLAGS			+=	-DPLAT_DRAM_SIZE=1024
TEXT_BASE=0x7fe00800
endif

PVFLAGS			+= 	-nostdinc -ffreestanding -D__ASSEMBLY__	\
				-P -E -D__LINKER__

%.o: %.S
	$(CC) $(CFLAGS) -c $< -o $@

l-loader.lds: l-loader.lds.S
	$(AS) $(PVFLAGS) -c $< -o $@


l-loader.bin: l-loader.lds start.o debug.o $(BL1)
	$(LD) -Bstatic -Tl-loader.lds -Ttext $(TEXT_BASE) start.o debug.o -o loader
	$(OBJCOPY) -O binary loader temp
	python gen_loader.py -o $@ --img_loader=temp --img_bl1=$(BL1)
	rm -f loader temp

ptable.img:
	sh generate_ptable.sh
	python gen_loader.py -o $@ --img_prm_ptable=prm_ptable.img --img_sec_ptable=sec_ptable.img

clean:
	rm -f l-loader.lds *.o *.img l-loader.bin
