#include "platform_def.h"
/*
 * Copyright (c) 2014 Linaro Ltd.
 */

OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_start)
SECTIONS
{
	. = PLAT_LLOADER_START;
	LLOADER_START = .;

	.text :
	{
		*(.text)
		*(.rodata)
	}

	.data ALIGN(4):
	{
		*(.data)
	}

	. = ALIGN(4);

	.bss ALIGN(4):
	{
		*(.bss)
	}

	LLOADER_BL1_BIN = PLAT_LLOADER_BL1;
}
