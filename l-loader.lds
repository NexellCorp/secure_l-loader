OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_start)
SECTIONS
{
 . = ((0x40000000 + 0x40000000 - 0x200000) + 0x800);
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
 LLOADER_BL1_BIN = ((0x40000000 + 0x40000000 - 0x200000) + 0x1000);
}
