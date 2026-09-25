# Histórico das tentativas

A execução histórica OpenXeChain Full XEX Build #14 no SMNEStoX360 (13/09/2026) compilou e instalou o cross compiler e xecorelib, mas falhou ao configurar/construir Newlib. O log detalhado de Newlib não foi preservado como artifact. Railway também foi tentado, porém o processo de LLVM/Ninja foi morto próximo de 2 GB de RAM, consistente com pressão de memória/OOM no plano disponível.

Decisão: usar GitHub Actions público como ambiente principal, preservar logs incondicionalmente e não repetir Railway sem mudança concreta de recursos/estratégia.
