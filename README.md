# OpenXeChain-X360-Builder

## 🧭 Comece aqui — projetos Xbox 360 PMCN Studios

**[ABRIR PAINEL CENTRAL DOS PROJETOS](docs/PAINEL_PMCN_XBOX360.md)** — status real do SM64, SMB de NES, compilador na nuvem, tarefas pendentes e links para continuar pelo celular.

**Compilador validado em CI:** [OpenXeChain Xbox 360 Toolchain v1](https://github.com/PedroMarioaBros/OpenXeChain-X360-Builder/releases/tag/openxechain-x360-toolchain-v1), com Clang, linker, bibliotecas e SynthXEX; produziu `hello.xex` com cabeçalho XEX2. Isso **não garante boot de qualquer programa nem gera ports automaticamente**. O status de cada jogo fica no painel.

---


Fábrica pública e reproduzível de toolchain/XEX para os projetos Xbox 360 da PMCN Studios.

## Objetivo

Construir a OpenXeChain em infraestrutura gratuita do GitHub Actions, preservar diagnóstico completo quando falhar e, quando tiver sucesso, publicar como artifact temporário uma toolchain reutilizável acompanhada de um XEX mínimo de smoke test.

## Evidência anterior

A tentativa histórica no repositório SMNEStoX360 provou que GitHub Actions consegue construir o cross-compiler LLVM/Clang e o xecorelib. O bloqueio observado ocorreu ao iniciar/configurar Newlib. A tentativa antiga não preservou o build.log/config.log necessários para identificar a causa exata. Esta fábrica existe para corrigir justamente essa deficiência.

O commit de buildscript está fixado em `eed1fa65bf9577fd31625764b320a90182ea9ade`. Não atualizar o pin sem uma mudança deliberada e documentada.

## Critério de sucesso

1. build completo da toolchain;
2. `clang`, `lld-link` e `synthxex` presentes;
3. compilação de `smoke/hello.c`;
4. geração de `hello.xex`;
5. primeiros quatro bytes exatamente `XEX2`;
6. empacotamento da toolchain e SHA-256.

Em qualquer falha, o workflow usa `if: always()` para tentar publicar logs, incluindo todos os `build.log` e `config.log` encontrados. Nada é declarado funcional sem evidência do Actions.
