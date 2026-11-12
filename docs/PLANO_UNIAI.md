# Plano de implementação — Uni.A.I

> Use este arquivo como checklist da equipe **ou** cole a seção "Contexto" + uma fase por vez em um assistente de código.
> Regra de ouro: **uma tarefa = uma branch = um commit/PR**. Antes de cada commit rode `dart format . && flutter analyze && flutter test`.

## Contexto (cole no início de qualquer prompt)

```text
Projeto Flutter "Uni.A.I" (pacote plataforma_educacional). Arquitetura: Provider + ChangeNotifier.
Cada feature em lib/features/<nome>/{models,data,presentation/{controllers,pages,widgets}}.
Repositórios têm interface (ex.: ActivityRepository) e implementação InMemory...; controllers herdam
ListController<T> (core/presentation/list_controller.dart); listas usam UniControlledList.
AppProviders (core/di/app_providers.dart) cria tudo. Dados hoje são mock em memória; Chat IA é estático.
Regras: não quebrar testes existentes, manter null safety, não alterar a identidade visual,
não adicionar dependências sem avisar, mudanças pequenas e commitáveis separadamente.
```

---

## Fase 0 — Linha de base (todos, 30 min)

- [ ] `flutter pub get`
- [ ] `flutter analyze` → anotar quantos avisos/erros existem (print ou texto)
- [ ] `flutter test` → anotar o que falha
- [ ] `flutter run` em emulador Android → percorrer: login, home, agenda, grupos, chat, perfil, configurações
- [ ] Corrigir **tudo** que impedir compilar/rodar antes de qualquer outra tarefa
- [ ] Criar a branch `develop`; cada tarefa abaixo sai de `develop` e volta por Pull Request
- [ ] Conferir `git shortlog -sn` para ver quem já tem commits

---

## Fase 1 — Rápidas e seguras (1 a 2 h cada, sem risco)

### 1.1 Lints e formatação — *Qualidade*
- [ ] Adicionar `flutter_lints` em `dev_dependencies` e criar/atualizar `analysis_options.yaml`:
  ```yaml
  include: package:flutter_lints/flutter.yaml
  ```
- [ ] `dart format .` (o recuo de `app_providers.dart` e `app_routes.dart` está inconsistente)
- [ ] Corrigir os avisos do `flutter analyze` até zerar
- [ ] Commit: `chore: add flutter_lints and format code`

### 1.2 Limpeza de pastas vazias — *Arquitetura*
- [ ] Apagar `.gitkeep` de `core/errors`, `core/router`, `core/utils`, `core/theme`, `features`, `shared/widgets`
- [ ] Remover pastas que ficarem vazias (`core/errors`, `core/router`, `core/utils`)
- [ ] Commit: `chore: remove empty placeholder folders`

### 1.3 Botão duplicado — *Qualidade*
- [ ] Abrir `shared/widgets/gradient_button.dart` e ver o construtor
- [ ] Se necessário, adicionar `final bool expanded;` (largura total) sem alterar o uso atual
- [ ] Em `calendar_page.dart`, apagar a classe `_GradientButton` e usar `GradientButton(label: '+ Nova atividade', onPressed: ...)`
- [ ] Conferir visualmente o botão do Calendário (mesma altura/raio)
- [ ] Commit: `refactor(calendar): reuse shared GradientButton`

### 1.4 Datas com `intl` — *Qualidade*
- [ ] Criar `core/utils/date_format.dart` (ou `shared/uni_dates.dart`):
  ```dart
  import 'package:intl/intl.dart';
  class UniDates {
    static final _full = DateFormat('dd/MM/yyyy', 'pt_BR');
    static String full(DateTime d) => _full.format(d);
  }
  ```
- [ ] Trocar `'${_selected.day}/${_selected.month}/${_selected.year}'` e demais datas montadas à mão (`grep -rn "\.day}/" lib`)
- [ ] Commit: `refactor: format dates with intl`

### 1.5 Mensagem no estado de erro — *UI/UX*
- [ ] `UniErrorState`: aceitar `String? message` (padrão: "Algo deu errado. Tente novamente.")
- [ ] `UniControlledList`: passar uma mensagem amigável a partir de `controller.error`
- [ ] Commit: `feat(ui): show message in error state`

### 1.6 Acessibilidade básica — *UI/UX*
- [ ] Adicionar `tooltip:` em todo `IconButton` (`grep -rn "IconButton(" lib`)
- [ ] `Semantics(label: ...)` nos cards clicáveis (ActivityCard, GroupCard, TeacherCard)
- [ ] Testar com texto grande (Configurações do Android → tamanho da fonte) e corrigir overflows
- [ ] Commit: `feat(a11y): tooltips and semantics`

### 1.7 Estilos de texto centralizados — *Qualidade* (gradual)
- [ ] Criar `core/theme/app_text.dart` com `title`, `subtitle`, `body`, `caption`, `cardTitle` (use os tamanhos que já aparecem: 27 bold, 12, 13 w600, 11)
- [ ] Migrar **apenas** `UniPageLayout`, `UniPageHeader` e `UniCard` + 3 telas mais simples
- [ ] Não trocar os 181 usos de uma vez; migrar ao tocar em cada arquivo
- [ ] Commit: `refactor(theme): add AppText styles`

---

## Fase 2 — Arquitetura e lógica (meio dia cada)

### 2.1 `AppProviders` com repositórios injetáveis — *Arquitetura*
- [ ] Criar `AppRepositories` (classe simples) com um campo por repositório:
  ```dart
  class AppRepositories {
    AppRepositories({
      ActivityRepository? activities, GroupRepository? groups, FriendRepository? friends,
      TeacherRepository? teachers, PlannerRepository? planner,
      WorkloadRepository? workload, NotificationRepository? notifications,
    }) : activities = activities ?? InMemoryActivityRepository(),
         groups = groups ?? InMemoryGroupRepository(),
         /* ... demais iguais ... */;
    final ActivityRepository activities; /* ... */
  }
  ```
- [ ] `AppProviders({required child, AppRepositories? repositories})` usa `repositories ?? AppRepositories()`
- [ ] `main.dart` continua funcionando sem passar nada
- [ ] Teste: injetar um repositório fake e conferir o controller
- [ ] Commit: `refactor(di): inject repositories into AppProviders`

### 2.2 Atualização local sem spinner — *Arquitetura/UX*
Hoje `_mutate` chama `load()` e a lista inteira vira loading por 600 ms a cada salvamento.
- [ ] Em `ListController`, separar dois erros: `error` (falha de carga → tela de erro) e `actionError` (falha de ação → snackbar)
- [ ] `add`: `await _repository.add(item); _items = [..._items, item]; notifyListeners();`
- [ ] `update`: substituir pelo `id`; `delete`: remover pelo `id`
- [ ] Se a ação falhar: manter `_items`, preencher `actionError`, **não** mudar `status` para `error`
- [ ] Manter `load()` só para carga inicial e "Tentar novamente"
- [ ] Ajustar `test/controllers_test.dart` (criação, edição, exclusão e erro) — rodar `flutter test`
- [ ] Ajustar `calendar_page.dart` para checar `controller.actionError`
- [ ] Commit: `refactor(controller): update list locally after mutations`

### 2.3 Demonstrar o estado de erro sem editar código — *UI/UX*
- [ ] Criar um decorator `FlakyRepository<T>` (envolve qualquer `ListRepository<T>` e lança `StateError` quando `FaultSwitch.enabled` for `true`)
- [ ] `FaultSwitch` = `ValueNotifier<bool>` global em `core/data`
- [ ] Em Configurações, um `Switch` "Simular falha de carregamento" visível só se `kDebugMode` (ou se a equipe preferir, sempre, rotulado "Modo demonstração")
- [ ] Documentar no README (seção Demonstração)
- [ ] Commit: `feat(debug): toggle to simulate load failure`

### 2.4 Sobrecarga calculada de verdade — *Funcionalidade*
- [ ] Abrir `workload_controller.dart`/`in_memory_workload_repository.dart` e **confirmar se hoje é mock fixo**
- [ ] Criar `features/workload/domain/workload_analyzer.dart` (Dart puro):
  ```dart
  class WeekLoad { WeekLoad(this.weekStart, this.count); final DateTime weekStart; final int count;
    bool get overloaded => count > 3; }
  class WorkloadAnalyzer {
    static DateTime weekStartOf(DateTime d) {
      final day = DateTime(d.year, d.month, d.day);
      return day.subtract(Duration(days: day.weekday - 1)); // segunda-feira
    }
    static List<WeekLoad> byWeek(List<CalendarActivity> items) {
      final map = <DateTime, int>{};
      for (final a in items) { final w = weekStartOf(a.date); map[w] = (map[w] ?? 0) + 1; }
      return (map.entries.toList()..sort((a, b) => a.key.compareTo(b.key)))
          .map((e) => WeekLoad(e.key, e.value)).toList();
    }
  }
  ```
- [ ] `WorkloadPage` passa a ler `ActivityController` (`context.watch`) e usa o analyzer; "Sugestões" aparecem quando houver semana com `overloaded`
- [ ] Teste unitário: 4 atividades na mesma semana → `overloaded == true`; 3 → `false`
- [ ] Commit: `feat(workload): compute overload from calendar activities`

---

## Fase 3 — SQLite e funcionalidades reais (mais complexa)

### 3.1 Infraestrutura do banco — *Complexidade*
- [ ] `pubspec.yaml`: `sqflite`, `path`, `shared_preferences`, `crypto`; dev: `sqflite_common_ffi`
- [ ] Extrair os dados mock iniciais de cada `InMemory...Repository` para listas `const`/estáticas reutilizáveis (ex.: `activity_seed.dart`) — o SQLite usa a mesma semente
- [ ] Criar `core/data/app_database.dart`:
  ```dart
  class AppDatabase {
    static Future<Database> open({String? path}) async {
      final dbPath = path ?? p.join(await getDatabasesPath(), 'uniai.db');
      return openDatabase(dbPath, version: 1, onCreate: (db, _) async {
        for (final t in ['activities', 'study_groups', 'reminders']) {
          await db.execute('CREATE TABLE $t (id TEXT PRIMARY KEY, json TEXT NOT NULL)');
        }
        await db.execute('''CREATE TABLE users (
          id TEXT PRIMARY KEY, name TEXT NOT NULL, email TEXT NOT NULL UNIQUE,
          password_hash TEXT NOT NULL, salt TEXT NOT NULL)''');
        await db.execute('''CREATE TABLE chat_messages (
          id INTEGER PRIMARY KEY AUTOINCREMENT, role TEXT NOT NULL,
          text TEXT NOT NULL, created_at TEXT NOT NULL)''');
        // inserir sementes aqui (apenas na criação)
      });
    }
  }
  ```
  > Atenção: **não** nomeie a tabela `groups` (palavra reservada no SQLite). Use `study_groups`.
- [ ] Criar `core/data/sqlite_store.dart` (genérico, igual ao `InMemoryStore`):
  ```dart
  class SqliteStore<T extends Identified> implements ListRepository<T> {
    SqliteStore(this._db, this._table, this._fromJson, this._toJson);
    final Database _db; final String _table;
    final T Function(Map<String, Object?>) _fromJson;
    final Map<String, Object?> Function(T) _toJson;

    @override Future<List<T>> getAll() async {
      final rows = await _db.query(_table);
      return rows.map((r) => _fromJson(
        jsonDecode(r['json']! as String) as Map<String, Object?>)).toList();
    }
    @override Future<void> add(T e) => _db.insert(_table,
        {'id': e.id, 'json': jsonEncode(_toJson(e))}, conflictAlgorithm: ConflictAlgorithm.fail);
    @override Future<void> update(T e) async {
      final n = await _db.update(_table, {'json': jsonEncode(_toJson(e))},
          where: 'id = ?', whereArgs: [e.id]);
      if (n == 0) throw StateError('Item não encontrado.');
    }
    @override Future<void> delete(String id) =>
        _db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }
  ```
- [ ] `main()`: `final db = await AppDatabase.open();` e passar ao `AppProviders` (via `AppRepositories` da tarefa 2.1)
- [ ] Teste de store com `sqflite_common_ffi` + `inMemoryDatabasePath`: add → getAll → update → delete
- [ ] Commit: `feat(data): add SQLite database and generic store`

### 3.2 Calendário persistente — *Complexidade*
- [ ] `CalendarActivity.toJson()` / `fromJson()` (datas em `toIso8601String()`; enums por `name`)
- [ ] `ActivityRepository` ← `SqliteStore<CalendarActivity>`
- [ ] Teste: salvar atividade, recriar o repositório sobre o mesmo banco, atividade continua lá
- [ ] Verificação manual: criar atividade → fechar o app por completo → abrir → ela existe
- [ ] Commit: `feat(calendar): persist activities in SQLite`

### 3.3 Grupos persistentes
- [ ] `StudyGroup.toJson/fromJson` (inclui documentos/atividades anexados)
- [ ] Se `GroupRepository` tiver métodos além de `getAll/add/update/delete`, implementá-los numa subclasse de `SqliteStore`
- [ ] Verificação manual: criar grupo, anexar material, reiniciar app
- [ ] Commit: `feat(groups): persist study groups in SQLite`

### 3.4 Lembretes/notificações persistentes
- [ ] `Reminder.toJson/fromJson`; trocar o repositório; o estado dos switches deve sobreviver ao reinício
- [ ] Commit: `feat(settings): persist reminders`

### 3.5 Autenticação local + sessão — *Funcionalidade/Complexidade*
> É autenticação **local de demonstração** (sem servidor). Diga isso no README.
- [ ] `features/auth/data/user_repository.dart`: `register(name, email, password)`, `findByEmail(email)`
- [ ] Hash com salt (pacote `crypto`):
  ```dart
  String hashPassword(String password, String salt) =>
      sha256.convert(utf8.encode('$salt:$password')).toString();
  ```
  Salt aleatório: `base64Url.encode(List<int>.generate(16, (_) => Random.secure().nextInt(256)))`
- [ ] `SignUpPage` chama `AuthController.register(...)`; erro "e-mail já cadastrado" aparece no campo
- [ ] `LoginPage` chama `AuthController.login(email, password)`; erro "e-mail ou senha incorretos" (mesma mensagem para os dois casos)
- [ ] Remover `'Gabriel Muniz'`: `studentName` vem do usuário logado
- [ ] Sessão: salvar `userId` em `shared_preferences`; no início do app, se existir, ir direto para `AppRoutes.home` (ajustar `initialRoute`)
- [ ] `signOut()` limpa a sessão
- [ ] Proteção: rotas internas redirecionam ao login se `!signedIn` (pode ser um `onGenerateRoute` simples)
- [ ] Testes: cadastro duplicado falha; senha errada falha; login correto funciona
- [ ] Commit: `feat(auth): local registration, login and session`

### 3.6 Assistente do Chat — *Funcionalidade*
- [ ] Criar `features/ai_chat/domain/local_assistant.dart` (Dart puro, testável):
  ```dart
  class LocalAssistant {
    String reply(String question, List<CalendarActivity> activities, DateTime now) {
      final q = question.toLowerCase();
      if (q.contains('semana')) {
        final start = WorkloadAnalyzer.weekStartOf(now);
        final end = start.add(const Duration(days: 7));
        final week = activities.where((a) => !a.date.isBefore(start) && a.date.isBefore(end)).toList()
          ..sort((a, b) => a.date.compareTo(b.date));
        if (week.isEmpty) return 'Você não tem atividades nesta semana. Aproveite para adiantar estudos!';
        return 'Esta semana você tem:\n${week.map((a) => '• ${UniDates.full(a.date)} — ${a.title}').join('\n')}';
      }
      if (q.contains('hoje') || q.contains('plano')) { /* listar de hoje + sugerir blocos de estudo */ }
      if (q.contains('sobrecarga')) { /* usar WorkloadAnalyzer.byWeek */ }
      return 'Posso ajudar com: "o que vence esta semana?", "monte meu plano de hoje" ou "estou sobrecarregado?".';
    }
  }
  ```
  (ajuste `a.title`/`a.date` aos nomes reais do modelo)
- [ ] `ChatController` (ChangeNotifier) com lista de mensagens; ao enviar: grava a do usuário, aguarda ~500 ms ("digitando...") e grava a resposta
- [ ] Tabela `chat_messages` (já criada em 3.1) para o histórico; carregar ao abrir
- [ ] `ChatPage`: tocar numa sugestão envia aquela pergunta para a conversa (em vez da conversa fixa)
- [ ] Manter o aviso "a IA pode cometer erros"; deixar claro que é assistente local (sem LLM)
- [ ] (Opcional, avançado) interface `AssistantService` com a implementação local e outra `LlmAssistantService` (HTTP); chave via `--dart-define=API_KEY=...`, **nunca** no repositório
- [ ] Testes do `LocalAssistant` (semana vazia, com atividades, intenção desconhecida)
- [ ] Commit: `feat(chat): local assistant using calendar data and history`

### 3.7 Fechamento
- [ ] Rodar o roteiro manual completo em emulador (login → criar atividade → grupo → chat → sobrecarga → reiniciar app)
- [ ] `flutter test --coverage` e anotar a cobertura no README
- [ ] `flutter build apk --release` e anexar o APK em um Release `v0.1.0` no GitHub
- [ ] Tirar os prints (tarefa 4.2) com os dados reais já persistidos

---

## Fase 4 — README, evidências e versionamento

### 4.1 README
- [ ] Substituir o README pelo novo (`README_NOVO.md`)
- [ ] Preencher `URL_DO_REPOSITORIO`, versão do Flutter (`flutter --version`) e licença
- [ ] Atualizar a tabela de status **somente** com o que estiver realmente pronto

### 4.2 Prints (pasta `screenshots/`)
- [ ] `01-boas-vindas.png`, `02-login.png`, `03-home.png`, `04-calendario.png`, `05-nova-atividade.png`
- [ ] `06-grupos.png`, `07-chat.png`, `08-planejamento.png`, `09-sobrecarga.png`, `10-notificacoes.png`
- [ ] Mesmo tamanho de tela/emulador em todos (ex.: Pixel 6)
- [ ] Opcional: um GIF curto de 20 s do fluxo principal

### 4.3 Divisão sugerida entre os 5 integrantes (todos com commits)
| Integrante | Tarefas |
|---|---|
| Bianca | 1.1, 1.2, 1.3, 2.1 (qualidade/arquitetura) |
| Rafaella | 3.1 + 3.2 (infra SQLite + Calendário) |
| Henrique | 3.3, 3.4 (Grupos e lembretes) + 2.2 |
| Nycolas | 3.5 (autenticação e sessão) + 1.6 |
| Rodrigo | 3.6 (Chat) + 2.4 (Sobrecarga) |
| Todos | 4.1/4.2 (cada um tira os prints das telas que fez), revisão cruzada de PR |

*(troquem livremente; o importante é que cada um tenha commits próprios com a conta do GitHub)*

- [ ] Configurar `git config user.name/email` com a conta correta em cada máquina
- [ ] Padrão de commit: `feat(escopo): ...`, `fix(...)`, `refactor(...)`, `docs(...)`, `test(...)`
- [ ] Todo PR com pelo menos 1 revisão de outro integrante
- [ ] No fim: `git shortlog -sn` mostra os 5 nomes

---

## Checklist final de entrega
- [ ] `flutter pub get && flutter analyze` sem avisos
- [ ] `flutter test` verde
- [ ] App abre, navega e **não perde dados ao reiniciar**
- [ ] README completo, com prints e sem placeholders
- [ ] Release `v0.1.0` com APK
- [ ] Commits dos 5 integrantes
