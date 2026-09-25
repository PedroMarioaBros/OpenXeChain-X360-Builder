#include <stdint.h>

volatile uint32_t pmcn_smoke_value = 0x58455832u;

__attribute__((noreturn)) void _start(void) {
    pmcn_smoke_value ^= 0x360u;
    for (;;) { __asm__ volatile("" ::: "memory"); }
}
