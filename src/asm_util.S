.global invalidate_cache_region
.global invoke_kernel_custom_code
.global invalidate_icache_all
.global invalidate_dcache_all

.equ CACHE_SIZE,      (16 * 1024)
.equ CACHE_LINE_SIZE, 32
.equ CACHE_LINES,     (CACHE_SIZE / CACHE_LINE_SIZE)
.equ CACHE_WAYS,      4

#define nop16b()                                                               \
  nop;                                                                         \
  nop;                                                                         \
  nop;                                                                         \
  nop                                                                          \

#define nop64b()                                                               \
  nop16b();                                                                    \
  nop16b();                                                                    \
  nop16b();                                                                    \
  nop16b()                                                                     \

#define nop256b()                                                              \
  nop64b();                                                                    \
  nop64b();                                                                    \
  nop64b();                                                                    \
  nop64b()                                                                     \

#define nop1kb()                                                               \
  nop256b();                                                                   \
  nop256b();                                                                   \
  nop256b();                                                                   \
  nop256b()                                                                    \

#define nop4kb()                                                               \
  nop1kb();                                                                    \
  nop1kb();                                                                    \
  nop1kb();                                                                    \
  nop1kb()                                                                     \

#define nop16kb()                                                              \
  nop4kb();                                                                    \
  nop4kb();                                                                    \
  nop4kb();                                                                    \
  nop4kb()                                                                     \

invalidate_cache_region:
  mov r2, #0x0
  swi 0x9f0002

  bx lr

invoke_kernel_custom_code:
  swi 0x90007a

  bx lr


invalidate_dcache_all:
  ldr r0, dcache_buffer
  mov r1, #(CACHE_SIZE / 2)

1:
  ldr r2, [r0], #4
  subs r1, r1, #1
  bne 1b

  bx lr

dcache_buffer:
  .word _dcache_buffer

.balign 16384

invalidate_icache_all:
  nop16kb()
  bx lr


.section bss

.balign 32768

.comm _dcache_buffer (CACHE_SIZE * 2)

