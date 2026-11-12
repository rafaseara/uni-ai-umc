# Uni.A.I. — aplicativo acadêmico (Flutter)

O **Uni.A.I.** reúne calendário de atividades, grupos de estudo, notificações, planejamento, perfil e um assistente local. Projeto acadêmico em Flutter/Dart, identificado pelo pacote `plataforma_educacional`.

**Repositório de referência da equipe:** https://github.com/rafaseara/uni-ai-umc

## Execução

Versão de referência informada pela equipe: **Flutter 3.47.9 / Dart 3.13.7**, canal `stable`. A SDK não estava disponível no ambiente em que estas alterações foram preparadas, então **análise, testes, APK e execução no emulador ainda dependem de validação local**.

```powershell
flutter --version
flutter pub get
dart format .
flutter analyze
flutter test
flutter run -d emulator-5554
```

Para gerar o APK quando os testes passarem:

```powershell
flutter test --coverage
flutter build apk --release
```

O APK fica normalmente em `build/app/outputs/flutter-apk/app-release.apk`. A publicação como Release `v0.1.0` precisa ser feita no GitHub pela equipe.

## O que foi implementado no código

| Funcionalidade | Implementação | Observações |
|---|---|---|
| UI, Provider, ChangeNotifier e rotas | Integrado | Identidade visual original preservada |
| `flutter_lints`, datas `intl`, estilos e acessibilidade | Integrado | Revisar `flutter analyze` e tamanho de fonte no aparelho |
| Injeção de repositórios | `AppRepositories` com substituição por fakes | Inclui implementação `sqlite` |
| Lista atualizada sem spinner | `ListController` com `actionError` separado | Ação malsucedida preserva conteúdo |
| Simular falha | `FaultSwitch` nas configurações | Apenas modo debug; usa calendário |
| Sobrecarga | `WorkloadAnalyzer` contando atividades por semana | Sobrecarga: **mais de 3** na mesma semana; sem diagnóstico clínico |
| SQLite | Atividades, grupos, lembretes, chat e usuários | Banco `uniai.db` com sementes somente na instalação |
| Cadastro/login/sessão | Cadastro e autenticação **locais**, hash SHA-256 com salt; sessão em `shared_preferences` | Demonstração offline; não é serviço de autenticação de produção |
| Chat | `LocalAssistant`, `ChatController`, histórico SQLite | Baseado em regras e calendário, **não é LLM** |
| Preferências de lembretes | `shared_preferences` | Persistem entre reinicializações no app móvel |

Atenção: repositórios de **amigos, professores, planejamento** e o antigo repositório de workload permanecem em memória. A página de Sobrecarga já não depende das métricas fixas do repositório de workload, e sim das atividades do calendário. O modo web, aberto por `flutter run -d chrome`, usa armazenamento temporário. A execução persistente foi concebida para Android/iOS; Windows/Linux desktop requerem configurar o backend SQLite FFI (o pacote `sqflite_common_ffi` está nas dependências de teste).

**Segurança:** esta implementação não envia credenciais a um servidor e não inclui recuperação real de senha. O armazenamento de senha com SHA-256 + salt foi incluído conforme o plano para demonstrar conceitos de autenticação local. Não deve ser empregado como autenticação de produção, nem para dados sensíveis. Recuperação/verificação por código é apenas protótipo e não altera credenciais. Além disso, as tabelas locais são compartilhadas no mesmo dispositivo: ainda não existe isolamento por usuário para atividades, grupos e histórico do chat.

## Arquitetura

```text
lib/
  core/
    data/                app_database, sqlite_store, in_memory_store, flaky_repository
    di/                  app_providers, AppRepositories
    navigation/          app_routes, uni_module_shell
    presentation/        list_controller
    theme/, utils/       estilos compartilhados, UniDates
  features/
    ai_chat/             ChatController, LocalAssistant, histórico
    auth/                AuthController, usuários locais
    calendar/            activities + SQLite
    study_groups/        groups + SQLite
    settings/            reminders + SharedPreferences
    workload/            WorkloadAnalyzer + tela
    friends/, teachers/, planner/, home/, profile/ ...
  shared/widgets/        estados/loading, botões, cards etc.
```

## Testes e roteiro manual

Testes adicionados: `workload_analyzer_test.dart`, `local_assistant_test.dart`, `sqlite_store_test.dart`, `local_mutation_test.dart`, `repositories_injection_test.dart`, `chat_controller_test.dart` e `notification_prefs_test.dart`. Testes existentes de login e controladores foram adaptados para autenticação local.

No emulador, executar este roteiro antes de publicar:

1. Abrir as boas-vindas → criar conta com nome, e-mail, data e senha → entrar.
2. Ir ao Calendário → criar/editar uma atividade → fechar completamente o app → reabrir → conferir atividade.
3. Criar um grupo, adicionar material e reiniciar o app para confirmar persistência.
4. Alterar switches em Notificações e reiniciar para confirmar preferências.
5. Conversar com o Chat sobre `o que vence esta semana?` e `monte meu plano de hoje`; reiniciar e confirmar histórico.
6. Cadastrar quatro atividades na mesma semana e verificar a seção de Sobrecarga.
7. Em debug, ligar `Simular falha de carregamento` nas Configurações, conferir erro no Calendário e desligar para recuperar.
8. Sair da conta e confirmar que rotas internas exigem login; fazer login novamente e verificar sessão.
9. Aumentar o tamanho da fonte do Android e testar possíveis overflows.

## Telas e evidências

A pasta `screenshots/` contém instruções com os nomes propostos no plano, mas **não inclui capturas reais**. Elas devem ser produzidas no emulador com um único tamanho de tela. Ainda não existe APK verificado nem relatório de cobertura; preencha esses itens após os comandos acima rodarem com sucesso.

## Trabalho em equipe e versionamento

Este ZIP traz **código-fonte sem a pasta `.git`** nem `build/`/`.dart_tool`. Para preservar os commits da equipe, aplique os arquivos no repositório Git clonado existente, de preferência em branches e PRs separados conforme `PLANO_UNIAI.md`.

Antes de fazer merge, cada integrante deve rodar `dart format .`, `flutter analyze` e `flutter test` e obter ao menos uma revisão de outro integrante. Os commits, PRs, screenshots e publicação da versão `v0.1.0` **não foram feitos automaticamente**.

**Licença:** a equipe ainda precisa definir formalmente a licença de distribuição. Até lá, não presumir uma licença de código aberto.
