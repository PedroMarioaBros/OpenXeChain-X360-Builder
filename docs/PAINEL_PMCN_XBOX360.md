# PMCN Studios — painel central de projetos Xbox 360

**Última auditoria consolidada: 09/10/2026.** Este é o ponto de entrada humano da família Xbox 360. O painel é um **retrato datado**, não um monitor automático de CI: antes de afirmar que algo está pronto, confira o workflow mais recente e o checkpoint do próprio projeto.

> Regra principal: **compilou ≠ XEX2 válido ≠ iniciou no console ≠ mostrou imagem/áudio ≠ jogo jogável**.

## Resumo em linguagem simples

| Frente | O que já existe comprovadamente | O que NÃO está pronto | Fonte atual |
| --- | --- | --- | --- |
| **Compilador OpenXeChain** | LLVM/Clang para PowerPC, linker, bibliotecas, SynthXEX e `hello.xex` produzidos via GitHub Actions. Toolchain v1 publicada em Release | Não é conversor universal de jogos; `hello.xex` não prova boot em hardware | [Toolchain v1](https://github.com/PedroMarioaBros/OpenXeChain-X360-Builder/releases/tag/openxechain-x360-toolchain-v1) · [CI bem-sucedida](https://github.com/PedroMarioaBros/OpenXeChain-X360-Builder/actions/runs/36198042207) |
| **Super Mario 64** | Base PT-BR 30 FPS testada em Xbox, reconstrução XEX e vários testes estáticos | Não há versão trilíngue/dublada pronta ou XEX novo liberado por causa dos testes de áudio | [Status simples](https://github.com/PedroMarioaBros/SM64toX360/blob/feature/multilang-dub-30fps/docs/STATUS_PARA_PEDRO.md) · [Ponto de retomada](https://github.com/PedroMarioaBros/SM64toX360/blob/feature/multilang-dub-30fps/PONTO_DE_RETOMADA.md) |
| **Super Mario Bros. NES** | Runtime da ROM SMB_v026 executado/testado em host; `default.xex` CANÔNICO de diagnóstico produzido com OpenXeChain | XEX diagnóstico **sem vídeo, áudio, controles ou boot comprovado**; não é jogo jogável | [Status simples](https://github.com/PedroMarioaBros/SMNEStoX360/blob/main/docs/STATUS_PARA_PEDRO.md) · [CI XEX canônico](https://github.com/PedroMarioaBros/SMNEStoX360/actions/runs/37958798039) |
| **PMCN Android Builder** | Workflow de geração de APK Android separado | Não compila jogos Xbox 360 | [Projeto Android](https://github.com/PedroMarioaBros/PMCN-Android-Builde) |
| **PMCN Xbox 360 Save Lab** | Laboratório de engenharia de saves | Não é compilador nem motor para ports | [Laboratório](https://github.com/PedroMarioaBros/PMCN-Xbox360-Save-Lab) |

## Organização oficial

1. **Fábrica de ferramentas:** [OpenXeChain-X360-Builder](https://github.com/PedroMarioaBros/OpenXeChain-X360-Builder) — fornece a toolchain. Não guarda o código dos jogos.
2. **Jogo SM64:** [SM64toX360](https://github.com/PedroMarioaBros/SM64toX360) — `main` é entrada de descoberta; desenvolvimento atual em `feature/multilang-dub-30fps`. Base 30 FPS, PT-BR própria preservada. **Não misturar a linha Native60**.
3. **Jogo NES:** [SMNEStoX360](https://github.com/PedroMarioaBros/SMNEStoX360) — desenvolvimento canônico em `main`, baseado **somente** em `assets/canonical/SMB_v026.nes`. Usar `canonical-xex.yml`; o workflow `xbox360-cloud-build.yml` pertence à rota antiga nathsou, que já teve Fatal Crash em hardware.
4. **Apoios, não ports:** Android Builder e Save Lab, mantidos independentes.

**Não mover binários, ROMs, saves, versões antigas ou branches durante uma simples organização.** Preservar hashes, histórico e testes de hardware. No SM64 os binários proprietários permanecem fora do repositório público; a ROM do NES está versionada por decisão expressa do proprietário.

## Situação e próxima tarefa de cada jogo

### Super Mario 64 — objetivo imediato: edição Português / Español / English

- **Funciona no Xbox:** a linha PT-BR estável de referência, com versões de controles/menu testadas.
- **CI verde recente:** validações de scripts e estruturas VADPCM, não uma edição multilíngue executável.
- **Não aprovado:** tentativa antiga `TITLE_SELECTOR_TEST1` causou regressão; não reutilizar o endereço registrado como reprovado.
- **Áudio:** patch BPS PT-BR e estrutura VADPCM investigados; **nenhuma voz extraída/decodificada e vinculada a eventos com prova suficiente**.
- **Próximo trabalho:** conferir os metadados, ponteiros, IDs de eventos e codebooks dos bancos de voz com dados genuínos; manter separada a correção do seletor e não entregar XEX especulativo.
- **Também pendente:** crawling aderido a paredes, inicialmente com escopo vertical. Não confundir planejamento com implementação.
- **Roteiro de teste físico:** só apresentar um novo pacote quando houver versão reconstruída, checksum, hipótese isolada e teste objetivo do que pode quebrar (boot, save, textos, áudio).

[Workflow de testes estáticos](https://github.com/PedroMarioaBros/SM64toX360/actions) · [auditoria de áudio](https://github.com/PedroMarioaBros/SM64toX360/blob/feature/multilang-dub-30fps/docs/PTBR_VADPCM_STRUCTURAL_AUDIT_2026_10_09.md).

### Super Mario Bros. NES — objetivo imediato: boot seguro e imagem

- **Funciona no host:** ROM canônica `SMB_v026` em runtime C99, com CPU/PPU/controles simulados e áudio PCM/WAV testado em cenários documentados.
- **Compilou na nuvem:** PowerPC `default.xex` do núcleo canônico e ROM embutida; formato XEX2 validado em CI.
- **Não funciona comprovadamente no Xbox:** não houve teste físico deste build. O executável atual é apenas diagnóstico **headless**.
- **Próximo trabalho:** tratar alerta do linker `/align ... without /driver`, teste de boot, tela de diagnóstico com API segura, controle e áudio Xbox. Não reutilizar framebuffer com endereços hardcoded do antigo build com Fatal Crash.
- **Linha paralela não concluída:** tradução estática NES 6502 → PowerPC sem interpretador; execução atual do PRG ainda usa interpretador C compilado para PPC.
- **Evitar confusão:** falhas do antigo `Compilar SMB Xbox 360` NÃO indicam que `Canonical NES Xbox 360 diagnostic XEX` falhou.

[Como retomar o NES](https://github.com/PedroMarioaBros/SMNEStoX360/blob/main/START_HERE.md) · [Próximos passos técnicos](https://github.com/PedroMarioaBros/SMNEStoX360/blob/main/docs/NEXT_STEPS.md).

## Como usar sem precisar trabalhar no PC

1. Abra o repositório do jogo no GitHub pelo navegador do celular.
2. Leia primeiro **STATUS_PARA_PEDRO.md**, depois o checkpoint indicado ali. Não precisa decifrar o histórico inteiro.
3. Em **Actions**, procure o workflow correto: para NES, **Canonical NES Xbox 360 diagnostic XEX**; para SM64, os workflows atuais são **testes/compilação de utilitários**, não build final do jogo.
4. Abra a última execução: **Success** confirma apenas as etapas daquele workflow. Consulte **Artifacts** para arquivos de saída. Um ZIP com nome de diagnóstico não é jogo pronto.
5. Para validar no Xbox, use somente um pacote com instruções e identificação clara. Registre *iniciou? imagem? controle? áudio? saves? crash?*.
6. Em novos chats/Work, forneça o link deste painel e peça para respeitar os checkpoints próprios dos projetos; **não recomeçar do zero**.

## Padrão único de status

Em cada atualização, declarar estes campos, mesmo que `NÃO TESTADO`:

| Campo | Valores permitidos e significado |
| --- | --- |
| **Código** | planejado / implementado / testado em host |
| **Compilação** | falhou / passou (link para Actions) / não executada |
| **Artefato** | nenhum / ferramenta / XEX de diagnóstico / candidato de jogo / versão estável |
| **Xbox físico** | não testado / não iniciou / iniciou / mostrou imagem / recebeu controles / áudio funcionando / jogável |
| **Fonte** | commit, branch, arquivos, hash e registro do teste |
| **Próxima ação** | uma tarefa objetiva, com requisito de aceitação |

Não anunciar **versão jogável** sem teste físico. Um artifact temporário pode expirar; Releases com hash podem ser permanentes. Nunca enviar ROMs/áudios ou XEXs protegidos ao repositório público sem autorização.

## Prioridade de organização

1. Preservar a **toolchain v1** e preferir builds canônicos já testados.
2. **SMB:** obter boot e vídeo seguro do XEX canônico; depois controle e áudio.
3. **SM64:** preservar a base PT-BR válida, resolver seletor e dados reais de dublagem separadamente; nenhuma alteração de 60 FPS nesta etapa.
4. Usar **um resultado técnico por checkpoint**, sem percentuais subjetivos nem builds fictícios.
5. Só iniciar novos ports após existir um fluxo mínimo reproduzível de código → CI → XEX → teste físico.

**Escopo desta reorganização:** documentação, navegação e classificação de workflows. Não altera binários de jogos nem comprova funcionamento físico novo.
