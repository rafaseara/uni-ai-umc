# Relatório das alterações em relação ao PLANO UNIAI

**Código produzido, não certificado por execução.** O ambiente de edição não dispõe da SDK Flutter/Dart nem de emulador; não foi possível executar `flutter pub get`, `flutter analyze`, `flutter test` ou gerar um APK. As dependências novas exigem atualizar o `pubspec.lock` com `flutter pub get` na máquina da equipe.

## Adicionado/modificado

- **Fase 1:** `flutter_lints` já existia; placeholders removidos; botão do calendário usa o componente compartilhado; datas via `UniDates`; estados de erro com mensagem; tooltips; semântica de cards; base `AppText`.
- **Fase 2:** `AppRepositories` injetável; controller atualiza listas sem nova carga; `actionError`; switch de falhas em debug; `WorkloadAnalyzer` e tela com métricas do calendário.
- **Fase 3:** esquema SQLite e `SqliteStore`; JSON de atividade, grupo e lembrete; repositórios SQLite; sessão e usuários locais; histórico Chat local; respostas do Chat com regras que consultam a agenda; preferências de lembrete em SharedPreferences; testes unitários escritos.
- **Fase 4:** README documentado, checklist de screenshots e plano original copiado para `docs/`.

## Pendente de validação/ações externas

- Executar SDK `flutter pub get`, `dart format .`, `flutter analyze`, `flutter test` e corrigir quaisquer diferenças de versões.
- Testar todo o fluxo no emulador Android, inclusive tamanho de fonte grande e persistência após reiniciar.
- Registrar cobertura, capturar imagens `screenshots/`, gerar APK, publicar release e fazer commits/PRs com as contas dos cinco integrantes.
- Recursos que continuam demonstrativos: recuperação de senha, amigos/professores/planejamento em memória, IA generativa, isolamento de dados por conta, tema persistente.
- O app não oferece backend de produção nem integração com serviços de IA.

## Instruções para preservar o Git existente

1. No repositório existente, crie uma branch de integração (`git switch -c feat/uniai-plano`).
2. Extraia **somente o conteúdo** do projeto deste ZIP por cima dos arquivos do repositório, sem substituir `.git`.
3. Na raiz do projeto rode `flutter pub get`, `dart format .`, `flutter analyze`, `flutter test` e `flutter run`.
4. Revise as diferenças (`git diff`) e distribua em commits menores/PRs por feature antes do merge.
