#include <stdint.h>
volatile uint32_t pmcn_smoke_value = 0x58455832u;
int main(void) {
    pmcn_smoke_value ^= 0x360u;
    for (;;) { __asm__ volatile("" ::: "memory"); }
    return 0;
}

/* CI trigger after HTTPS submodule rewrite. */
