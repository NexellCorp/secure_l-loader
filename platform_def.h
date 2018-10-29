#ifndef __PLATFORM_DEF_H__
#define __PLATFORM_DEF_H__

#if defined(PLAT_DRAM_SIZE) && PLAT_DRAM_SIZE == 2048
#define PLAT_DRAM_SZ			0x80000000
#elif defined(PLAT_DRAM_SIZE) && PLAT_DRAM_SIZE == 512
#define PLAT_DRAM_SZ			0x20000000
#elif defined(PLAT_DRAM_SIZE) && PLAT_DRAM_SIZE == 256
#define PLAT_DRAM_SZ			0x10000000
#else
#define PLAT_DRAM_SZ			0x40000000
#endif

#define PLAT_SECURE_BASE		(0x40000000 + PLAT_DRAM_SZ - 0x300000)
#define PLAT_LLOADER_START		(PLAT_SECURE_BASE + 0x800)
#define PLAT_LLOADER_BL1		(PLAT_SECURE_BASE + 0x1000)

#endif /* __PLATFORM_DEF_H__ */
