# uni-ai-umc
Aplicativo Flutter de apoio acadêmico com IA: organiza atividades, prazos e rotina de estudos para universitários. Projeto da UMC 2026.

# Sobre o projeto

O Uni.A.I é uma aplicação desenvolvida com o objetivo de auxiliar estudantes na organização da rotina acadêmica, promovendo a colaboração entre alunos e contribuindo para o equilíbrio das atividades de estudo.
O aplicativo reúne ferramentas de planejamento, organização e colaboração em um único ambiente. Atualmente os dados são demonstrativos (mock) e o Chat IA é simulado; não há backend, banco de dados ou IA real conectados.

# O projeto busca responder à seguinte questão:
Como conciliar provas, trabalhos, prazos e compromissos sem transformar a rotina de estudos em uma sobrecarga?

# Objetivos

- Facilitar a organização das atividades acadêmicas.

- Auxiliar no planejamento de tarefas e prazos.

- Promover a colaboração entre estudantes.

- Integrar inteligência artificial à rotina de estudos.

- Identificar padrões de sobrecarga acadêmica e incentivar uma melhor distribuição das atividades.

# Funcionalidades

O projeto contempla as seguintes funcionalidades:

- Calendário inteligente: organização de provas, trabalhos, tarefas e compromissos.

- Planejamento semanal: distribuição das atividades conforme prioridades e prazos.

- Grupos de estudo: ambiente para interação e colaboração entre estudantes.

- Documentos compartilhados: gerenciamento e atualização colaborativa de materiais.

- Inteligência artificial: assistente para auxiliar na organização e no planejamento acadêmico.

- Notificações e lembretes: avisos sobre atividades e prazos importantes.

- Acompanhamento de sobrecarga: identificação de padrões na rotina acadêmica para auxiliar na organização das atividades.

- Área de professores: espaço de acesso privado para acompanhamento e interação.

# Tecnologias

As tecnologias abaixo incluem a implementação atual e opções planejadas para versões futuras:
| Tecnologia | Aplicação |
| :--- | :---: |
| Flutter | Desenvolvimento da interface do aplicativo|
| Dart | Linguagem de programação do aplicativo |
| Python | Planejado: backend e integração com IA |
| FastAPI | Planejado: API REST |
| MySQL | Planejado: banco de dados |
| API de modelo de linguagem | Planejado: integração da IA |
| Git e GitHub | Versionamento e colaboração no desenvolvimento |


# Como executar o projeto
**Pré-requisitos**

Antes de executar o projeto, é necessário possuir:

- Flutter SDK instalado.
- Dart SDK instalado.
- Git instalado.
- Visual Studio Code ou outra IDE compatível.

# 1. Clonar o repositório

Abra o terminal e execute:
```text
git clone URL_DO_REPOSITORIO
```
Entre na pasta do projeto:
```text
cd NOME_DO_PROJETO
```

# 2. Executar o aplicativo Flutter

Acesse a pasta do aplicativo e instale as dependências

```text
flutter pub get
```
Execute o aplicativo:

```text
flutter run
```

# 3. Backend e integrações futuras

**Ainda não disponíveis.** O protótipo atual é Flutter/Dart com dados mock e Chat IA simulado. Não é necessário instalar Python, MySQL, FastAPI ou qualquer servidor para executar as telas do aplicativo.

# Telas do projeto

Nesta seção serão apresentados registros visuais das interfaces do Uni.A.I.

As imagens devem demonstrar as principais telas e funcionalidades da plataforma.


| Tela| Descrição|
| :--- | :---: |
| Tela inicial |Apresentação e acesso às funcionalidades|
| Calendário | Visualização dos compromissos acadêmicos |
| Planejamento semanal | Organização das atividades da semana |
| Grupos de estudo |Colaboração entre estudantes |
| Assistente de IA | Interação com a inteligência artificial |
| Notificações | Lembretes e avisos importantes |
| Sobrecarga acadêmica | Acompanhamento dos padrões da rotina |

As imagens serão armazenadas na pasta screenshots/ do repositório.

# Equipe de desenvolvimento

Universidade de Mogi das Cruzes — UMC

Curso: Engenharia de Software

Ano: 2026

# Integrantes

- Bianca Battestin Gonçalves
- Rafaella Seara Cardoso
- Henrique Gonçalves Mendonça
- Nycolas Viera Rosa Soares
- Rodrigo da Silva Poyatos

# Orientadores

- Prof.ª Higor Barreto Campos

# Versionamento

O desenvolvimento do Uni.A.I utiliza Git e GitHub para controle de versão e colaboração entre os integrantes da equipe.

As alterações são registradas por meio de commits, permitindo acompanhar a evolução do projeto, identificar modificações e manter o histórico de desenvolvimento.

Cada integrante deve contribuir com alterações identificadas em sua própria conta do GitHub.

 # Status do projeto

O projeto possui seu protótipo desenvolvido e estruturado, encontrando-se na etapa de preparação para o desenvolvimento completo da aplicação.

As próximas etapas incluem implementação do aplicativo e backend, integração com o banco de dados e inteligência artificial, testes com usuários e aprimoramentos da plataforma.


**Uni.A.I — Organização, colaboração e inteligência artificial para transformar a rotina de estudos.**




## Etapa 1 — Identidade visual compartilhada

**Estado atual:** os dados exibidos são mock (fixos) e o Chat IA é simulado. Não há integração de banco de dados, API nem IA real nesta etapa. A lista de tecnologias acima representa possibilidades planejadas, não funcionalidades já implementadas.

- `lib/core/theme/app_colors.dart`: tokens de cores e degradê rosa → azul, baseados no login.
- `lib/core/theme/app_theme.dart`: tema escuro Material configurado em `main.dart`.
- `lib/shared/widgets/uni_background.dart`: único fundo de tela com dois glows e `SafeArea`.
- `lib/shared/widgets/gradient_button.dart`: botão de borda em degradê, reutilizado em autenticação e grupos.
- `lib/features/`: páginas e widgets de apresentação organizados por recurso.
- `lib/core/navigation/app_routes.dart`: nomes centralizados das rotas usadas pelo app.

### Como validar

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

Verificação manual recomendada: navegue do login para Início, Agenda, Grupos,
Chat IA, Professores, Amigos, Perfil, Configurações e Sobrecarga; confira glows,
cores de cards, botões, bordas, barra inferior, modais, telas vazias e fluxo de
voltar. Os comandos acima devem ser executados localmente com Flutter instalado.

## Etapa 2 — Cabeçalho, layout e cards compartilhados

A estrutura visual das páginas internas usa três widgets reutilizáveis:

- `lib/shared/widgets/uni_page_header.dart` — barra de 56 px com voltar, marca Uni + A.I. azul e notificações. Quando não existe rota anterior, o botão volta para `AppRoutes.modules` (se já estiver na página de módulos, não abre outra cópia).
- `lib/shared/widgets/uni_page_layout.dart` — `UniBackground`, cabeçalho, título 27 bold, subtítulo 12, `children` roláveis com padding horizontal de 20. Também aceita `showBack`, `bottom`, `floatingAction` e extensões para páginas sem título ou com ação junto ao título.
- `lib/shared/widgets/uni_card.dart` — cor, borda, raio 12 e padding centralizados. Cards especializados preservam seu comportamento e conteúdo.

Foram migrados calendário (inclusive cadastro/salvamento de atividade), planejamento, sobrecarga, professores, chat (inclusive conversa), configurações, notificações, amigos, grupos, módulos e perfil. A Home utiliza o mesmo cabeçalho e `UniCard`, mantendo seu layout de painel. Na Etapa 3, a barra inferior foi transferida para o `UniModuleShell`. Login, cadastro, boas-vindas e saída preservam seus layouts próprios, pois não são páginas internas de módulos.

### Validação local

Execute, na raiz do app, usando o Flutter SDK compatível com `pubspec.yaml`:

```bash
flutter pub get
dart format lib test
flutter analyze
flutter test
flutter run
```

Os testes de widgets estão em `test/page_components_test.dart` e validam montagem de página, notificações, retorno sem histórico e aparência de card. A execução dos testes e do analisador ainda depende da máquina com Flutter instalado.

**Checklist manual:**

1. Login e Home: identidade visual do login preservada, logo e cabeçalho com dimensões consistentes, barra inferior funcional.
2. Módulos, calendário, amigos, professores, planejamento, sobrecarga, configurações e perfil: título e subtítulo corretos, conteúdo rolável sem overflow, ícones e botão voltar funcionando.
3. Notificações: sino abre a tela correta e voltar não cria rotas duplicadas.
4. Calendário: navegação de mês, selecionar data, criar/editar atividade, salvar e voltar ao calendário.
5. Grupos: buscar, criar, abrir detalhes, adicionar documentos/atividades, navegação inferior e botão voltar.
6. Chat IA: sugestões navegam para conversa, envio de mensagens mock e barra de digitação visível quando o teclado abre.
7. Cards: raio/borda consistentes; seleções, cartões clicáveis, estados vazios e diálogos continuam operando.


## Etapa 3 — Navegação e barra inferior compartilhadas

- **Rotas centralizadas:** `lib/core/navigation/app_routes.dart` concentra os nomes das rotas e a lista ordenada de cinco abas (`tabRoutes`). Todas as chamadas de navegação nomeada utilizam `AppRoutes.*`.
- **Transição sem empilhamento:** `AppRoutes.goToTab` usa `Navigator.pushNamedAndRemoveUntil` para preservar a Home como base enquanto substitui a aba anterior. `AppRoutes.openModule` também encaminha os atalhos do menu para essa navegação ao abrir uma aba. Ao voltar à Home, limpa a pilha. O botão voltar do cabeçalho em abas secundárias também retorna à Home.
- **Barra única:** `lib/shared/widgets/uni_bottom_nav.dart` implementa `UniBottomNav`, exibida apenas pelo `UniModuleShell`. Home e Grupos não constroem sua própria barra.
- **Seleção contextual:** Home, Grupos, Chat IA, Agenda e Perfil selecionam respectivamente as abas 0 a 4; Módulos, Planejamento, Sobrecarga, Professores, Amigos, Configurações e Notificações não selecionam nenhuma aba. O usuário pode mudar para qualquer aba sem empilhar essas páginas.
- **Páginas de detalhes:** conversa do chat, perfil/planos de professor, criação/detalhes de grupo, busca de amigos e formulário/confirmação de atividade são abertas sem o shell e sem barra inferior. Páginas de autenticação e saída também ficam fora do shell; telas de autenticação com formulário têm botão de voltar.
- **Ações resolvidas:** o login oferece apenas “Esqueci a senha”; a Home não possui mais mensagens de ação não conectada. Os comandos visuais de tema e segurança nas Configurações respondem com estado demonstrativo ou diálogo, sem alterar o tema global nem acessar serviços externos.

### Como validar a navegação

Na raiz do projeto, com Flutter 3.47 ou versão compatível com o `pubspec.yaml`:

```powershell
flutter pub get
dart format lib test
flutter analyze
flutter test
flutter run
```

Execute os cenários manuais:

1. Entre pelo login e alterne **Início → Grupos → Chat IA → Agenda → Perfil** repetidamente. Cada aba deve exibir apenas uma barra inferior; ao usar voltar (app ou sistema), retorna-se à Home.
2. Da Home, abra Módulos → Planejamento, Sobrecarga, Professores, Amigos, Configurações e Notificações. A barra inferior deve aparecer sem seleção; tocar em outra aba deve remover essas telas intermediárias da pilha.
3. No Chat IA, abra uma conversa e retorne: a conversa não possui barra, a tela inicial do chat possui.
4. Em Calendário, abra o formulário e a confirmação; em Grupos, criação e detalhes; em Amigos, busca; em Professores, perfil e planos. Nenhuma dessas telas de detalhe deve ter barra inferior, e todas devem permitir retorno.
5. Em Perfil, abrir “Sua conta” deve continuar exibindo a barra por ser uma tela raiz. “Continuar conectado” volta à página anterior.
6. No login, confirme que existe somente “Esqueci a senha” e que abre o fluxo de recuperação; confirme também o retorno ao início de autenticação.
7. Em Configurações, teste o controle de tema demonstrativo, o diálogo de segurança e o acesso à senha. Confirme que o logout encerra a pilha da área autenticada.

Testes de navegação automatizados adicionados em `test/navigation_test.dart`. **Não executados neste ambiente:** o Flutter/Dart SDK não está instalado; esses comandos devem ser rodados e quaisquer problemas reportados corrigidos no emulador local.

**Commits sugeridos:** `refactor(navigation): centralize tab routes and replace stack on tab switch`; `refactor(ui): share module bottom navigation`; `fix(auth): deduplicate password recovery action`; `test(docs): cover navigation stack and document flows`.

## Etapa 4 — Estados de UI e validação dos formulários

Esta etapa mantém **dados apenas em memória**, **IA simulada** e **nenhuma API, SQLite ou autenticação real**.

- `lib/shared/widgets/uni_empty_state.dart`: componente `UniEmptyState` com ícone, título, mensagem e ação opcional. Substitui `TeachersEmptyState`.
- `lib/shared/widgets/uni_loading.dart`: `UniLoading` centralizado com indicador circular azul.
- `lib/shared/widgets/uni_error_state.dart`: `UniErrorState` com mensagem e botão **Tentar novamente**.
- `lib/shared/widgets/uni_async_list.dart`: `UniAsyncList<T>` usa `FutureBuilder` para exibir carregamento, erro, vazio e dados; faz retry sem reconstruir toda a página e recarrega quando `revision` muda.
- `lib/shared/data/mock_loader.dart`: `MockLoader.load<T>` retorna cópia dos dados após **600 ms**; não acessa rede/banco. Os dados mock de Amigos, Professores, Planejamento, Sobrecarga e Notificações ficam em `features/*/data`.
- `lib/shared/uni_validators.dart`: validações compartilhadas de campos obrigatórios, e-mail, data de nascimento (`DD/MM/AAAA`) e confirmação de senha. `AuthTextField` agora usa `TextFormField` e exibe mensagens abaixo do campo.
- Páginas atualizadas: **Calendário**, **Grupos** (lista e busca), **Amigos** (lista e busca), **Professores** (busca e filtros), **Planejamento**, **Sobrecarga** e **Notificações**. Calendário e Grupos recarregam os dados mock ao salvar/criar.
- Formulários atualizados: **Login, Cadastro, Código de verificação, Nova senha, Criar Grupo e Atividade**. O código de verificação e login permanecem demonstrativos.

### Verificação no computador

```powershell
flutter pub get
dart format lib test
flutter analyze
flutter test
flutter run
```

A verificação local deste pacote foi **somente estática**; não substitui o analisador Dart, os testes de widget e os testes em emulador. Veja `test/ui_states_test.dart` para loading (600 ms), vazio, erro/retry e formulário.

### Checklist manual da Etapa 4

1. No **Calendário**, selecione um dia vazio (deve mostrar uma mensagem), crie uma atividade e volte: deve surgir loading antes de mostrar o card no dia escolhido.
2. Em **Grupos**, busque um nome inexistente (vazio com explicação), crie um grupo e confira sua aparição após o loading.
3. Em **Amigos / Buscar amigos**, pesquise algo inexistente; em **Professores**, teste o filtro e uma busca sem correspondência.
4. Em **Planejamento / Sobrecarga / Notificações**, confirme o spinner azul inicial (~600 ms) e a chegada dos dados demonstrativos.
5. Para inspecionar manualmente o **estado de erro**, altere temporariamente o `load` de um `UniAsyncList` para retornar `Future.error(StateError('teste'))`; confira mensagem e botão **Tentar novamente**, depois restaure o loader. O teste automatizado já cobre falha na primeira tentativa e sucesso na segunda.
6. Submeta **Login** e **Cadastro** com e-mail inválido e campos vazios; experimente uma data impossível. Em **Nova senha**, digite senhas diferentes ou com menos de seis caracteres.
7. Envie **Criar Grupo** sem nome ou descrição e **Nova atividade** sem título; confirme que os erros aparecem no campo, sem navegar. Com valores válidos, confira os fluxos originais.

**Commits sugeridos (não executados):** `feat(ui): add reusable loading empty error states`; `feat(mock): async list loading and retry`; `fix(forms): inline validation for authentication and creation`; `test(docs): cover UI states and forms`.

## Arquitetura atual — Etapa 5 (sem banco de dados)

A aplicação utiliza **Provider + ChangeNotifier**. Os dados de demonstração não são mantidos nos `State` das páginas: ficam em repositórios em memória, criados uma vez pelo `AppProviders` (`lib/core/di/app_providers.dart`). Os controladores sobrevivem às trocas de rota, e alterações feitas no calendário ou nos grupos continuam disponíveis até o aplicativo ser encerrado. Não há persistência em disco e os dados voltam ao estado inicial após reiniciar o app.

```text
lib/
  core/
    data/                  # ListRepository<T> e implementação genérica em memória
    di/app_providers.dart  # registro único dos controllers
    models/                # Identified e enum Priority
    presentation/          # ListController<T>, estados loading/ready/error
  features/
    calendar/              # modelos, repositório e ActivityController
    study_groups/          # modelos, repositório e GroupController
    friends/               # modelos, repositório e FriendController
    teachers/              # modelos, repositório e TeacherController
    planner/               # modelos, repositório e PlannerController
    workload/              # modelos, repositório e WorkloadController
    settings/              # Reminder, NotificationRepository e NotificationController
    auth/presentation/controllers/auth_controller.dart
  shared/widgets/uni_controlled_list.dart
```

Cada feature separa **`models/`** (objetos imutáveis com identificadores), **`data/`** (interface e implementação `InMemory...Repository`) e **`presentation/controllers/`** (estado e ações). As telas obtêm os controladores usando `context.watch<T>()` e `context.read<T>()` e **não dependem de repositórios diretamente**. `UniControlledList` apresenta carregamento (~600 ms), vazio e erro com tentativa novamente.

### Ponto de extensão para SQLite — futuro, NÃO implementado

Para trocar o armazenamento, crie uma implementação do contrato da feature, por exemplo `SqliteActivityRepository implements ActivityRepository`, com `getAll`, `add`, `update` e `delete`, mais os métodos adicionais de cada contrato quando houver. Altere **somente** a implementação injetada em `AppProviders` e inicialize o banco no início da aplicação. Preserve os modelos tipados e os controllers/telas. Nenhuma dependência `sqflite` foi adicionada nesta etapa.

### Rodar e validar

```bash
flutter pub get              # necessário para atualizar pubspec.lock após retirar go_router
dart format lib test
flutter analyze
flutter test
flutter run
```

Testes novos: `test/controllers_test.dart` cobre **AuthController e os sete controllers de dados**, incluindo criação, edição, exclusão, erro e retenção em memória. `test/login_navigation_test.dart` cobre login demonstrativo e troca de abas. `test/ui_states_test.dart` cobre o widget de estado e botão de tentar novamente. Também foram preservados os testes de tema, layout e navegação das etapas anteriores.

Verificação manual sugerida: faça login, crie e edite uma atividade, navegue para a Home e volte ao calendário, crie um grupo, anexe material, volte e abra o grupo novamente; confira se os dados permanecem. Reinicie o aplicativo para confirmar que voltam aos mocks originais. Abra telas de lista para conferir loading e experimente os switches de notificações e a sugestão do planejamento.
