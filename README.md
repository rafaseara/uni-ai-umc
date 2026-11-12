# Uni.A.I.
 
> Aplicativo acadêmico em Flutter que reúne calendário de atividades, grupos de estudo, lembretes, análise de sobrecarga e um assistente de estudos local. Projeto acadêmico em Flutter/Dart, identificado pelo pacote `plataforma_educacional`.

![Flutter](https://img.shields.io/badge/Flutter-stable-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.13.7-0175C2?logo=dart&logoColor=white)
![Plataforma](https://img.shields.io/badge/Plataforma-Android%20%7C%20iOS-3DDC84)
![Versão](https://img.shields.io/badge/versão-0.1.0-blue)
 
**Disciplina:** `Desenvolvimento de Aplicativos` · **Instituição:** `UMC - Universidade de Mogi das Cruzes` · **Professor(a):** `Higor Barreto Campos`
**Pacote:** `plataforma_educacional` · **Repositório:** https://github.com/rafaseara/uni-ai-umc

---
 
## Sumário
 
1. [Sobre o projeto](#sobre-o-projeto)
2. [Funcionalidades](#funcionalidades)
3. [Tecnologias](#tecnologias)
4. [Arquitetura](#arquitetura)
5. [Como executar](#como-executar)
6. [Testes](#testes)
7. [Roteiro de validação manual](#roteiro-de-validação-manual)
8. [Decisões e limitações](#decisões-e-limitações)
10. [Equipe](#equipe)
---

## Sobre o projeto
 
O **Uni.A.I.** ajuda estudantes a organizarem a rotina acadêmica em um só lugar. O aluno cadastra suas atividades no calendário, acompanha prazos, participa de grupos de estudo, configura lembretes e recebe alertas quando uma semana fica carregada demais. Um assistente local responde perguntas sobre a agenda e sugere um plano de estudos.
 
**Problema que resolve:** `Estudantes enfrentam dificuldade para acompanhar prazos acadêmicos devido à descentralização de informações em múltiplas plataformas, o que gera falta de planejamento e sobrecarga de tarefas na mesma semana.`
 
**Público-alvo:** `principal: estudantes do ensino superior, secundário: professores e instituições de ensino.`

---

## Funcionalidades
 
| Funcionalidade | Descrição | Persistência |
|---|---|---|
| Cadastro, login e sessão | Cria conta local e mantém o usuário logado entre aberturas do app. Rotas internas exigem login. | SQLite + `shared_preferences` |
| Calendário | Cria, edita e remove atividades com data, hora, duração, prioridade e lembrete. | SQLite |
| Grupos de estudo | Cria grupos, vê detalhes e adiciona materiais. | SQLite |
| Notificações | Liga e desliga lembretes; as preferências sobrevivem ao reinício do app. | SQLite + `shared_preferences` |
| Chat com assistente | Responde "o que vence esta semana?", "monte meu plano de hoje" e "estou sobrecarregado?". O histórico é salvo. | SQLite |
| Sobrecarga acadêmica | Conta atividades por semana (segunda a domingo) e sinaliza **mais de 3** na mesma semana. | Calculado a partir do calendário |
| Estados de interface | Carregando, erro com "Tentar novamente" e lista vazia, de forma padronizada. | — |
| Simulação de falha | Chave nas Configurações (somente em modo debug) para demonstrar o estado de erro. | — |
| Amigos, professores e planejamento semanal | Telas com dados de demonstração. | Memória (não persiste) |
---

## Tecnologias
 
| Camada | Tecnologia | Uso no projeto |
|---|---|---|
| Framework | **Flutter** / **Dart 3.13.7** | Interface e lógica, com null safety |
| Estado | **provider** + `ChangeNotifier` | Controllers por funcionalidade |
| Banco local | **sqflite** + **path** | Atividades, grupos, lembretes, chat e usuários |
| Preferências | **shared_preferences** | Sessão do usuário e preferências de lembretes |
| Segurança | **crypto** | Hash SHA-256 com salt para senhas (demonstração) |
| Datas e idioma | **intl** + **flutter_localizations** | Datas em pt-BR |
| Qualidade | **flutter_lints** | Análise estática (`flutter analyze`) |
| Testes | **flutter_test** + **sqflite_common_ffi** | Testes de unidade, de widget e de banco |
---

## Arquitetura
 
Organização por funcionalidade (*feature-first*), com separação entre interface, lógica e dados.
 
```text
lib/
  main.dart                  inicialização (banco, sessão, providers)
  core/
    data/                    app_database, sqlite_store, in_memory_store, flaky_repository
    di/                      app_providers (AppRepositories + MultiProvider)
    models/                  contratos e tipos compartilhados
    navigation/              app_routes (rotas e guarda de login), uni_module_shell
    presentation/            list_controller (estados genéricos de lista)
    theme/                   cores, textos e tema
    utils/                   formatação de datas (UniDates)
  features/
    auth/                    cadastro, login, sessão
    calendar/                atividades
    study_groups/            grupos de estudo
    settings/                configurações e lembretes
    ai_chat/                 chat e assistente local
    workload/                análise de sobrecarga
    home/, profile/, friends/, teachers/, planner/, logout/
  shared/widgets/            componentes reutilizáveis (cards, botões, loading, erro, vazio)
```
 
Cada funcionalidade segue o mesmo padrão:
 
```text
feature/
  data/            interface do repositório + implementações (memória e SQLite)
  models/          entidades imutáveis, com toJson/fromJson quando persistidas
  domain/          regras puras, sem Flutter (ex.: WorkloadAnalyzer, LocalAssistant)
  presentation/    controllers (ChangeNotifier), páginas e widgets
```
---

## Como executar
 
Passo 1: Verificar Pré-requisitos
Certifique-se de ter instalado em sua máquina:

Flutter (canal stable, versão 3.13.7 ou superior) com Dart.

Android Studio ou Xcode.

Um emulador configurado ou um aparelho físico conectado.

Passo 2: Baixar e Acessar o Repositório
Abra o seu terminal e execute os comandos abaixo para clonar o projeto e entrar na pasta:

Bash
git clone https://github.com/rafaseara/uni-ai-umc.git
cd uni-ai-umc
Passo 3: Instalar as Dependências
Verifique se a sua versão do Flutter está correta e baixe os pacotes necessários:

Bash
flutter --version
flutter pub get
Passo 4: Executar o Aplicativo
Para rodar no dispositivo padrão detectado, execute:

Bash
flutter run
Dica para escolher o dispositivo:
Se tiver mais de um aparelho/emulador conectado, liste-os com flutter devices e inicie em um específico usando:

Bash
flutter run -d <id-do-dispositivo>
(Exemplo para rodar no navegador web: flutter run -d chrome)

📱 Observações Importantes por Plataforma
Android / iOS: Execução completa e com dados persistentes salvos localmente.

Web: Utiliza armazenamento temporário (os dados são perdidos ao recarregar a página).

Desktop (Windows / Linux): Necessita de configuração prévia do backend SQLite FFI (sqflite_common_ffi).

📦 Gerar o APK de Produção
Assim que os testes estiverem passando, você pode gerar a versão final para instalação no Android:

PowerShell
flutter test --coverage
flutter build apk --release
O arquivo final (app-release.apk) estará disponível em:build/app/outputs/flutter-apk/app-release.apk
---

## Testes
 
```bash
dart format .
flutter analyze
flutter test
flutter test --coverage
```
 
| Área | Arquivos |
|---|---|
| Regra de sobrecarga | `workload_analyzer_test.dart` |
| Assistente e chat | `local_assistant_test.dart`, `chat_controller_test.dart` |
| Banco e persistência | `sqlite_store_test.dart`, `local_mutation_test.dart`, `notification_prefs_test.dart` |
| Injeção de dependências | `repositories_injection_test.dart` |
| Controllers | `controllers_test.dart` |
| Interface e navegação | `ui_states_test.dart`, `navigation_test.dart`, `login_navigation_test.dart`, `page_components_test.dart`, `theme_test.dart`, `widget_test.dart` |
---

## Roteiro de validação manual
 
1. Abrir as boas-vindas, criar conta (nome, e-mail, data e senha) e entrar.
2. No Calendário, criar e editar uma atividade, fechar o app por completo, reabrir e conferir que ela continua lá.
3. Criar um grupo de estudo, adicionar um material, reiniciar e confirmar a persistência.
4. Alterar os switches em Notificações, reiniciar e confirmar que as preferências foram mantidas.
5. No Chat, perguntar `o que vence esta semana?` e `monte meu plano de hoje`; reiniciar e confirmar o histórico.
6. Cadastrar quatro atividades na mesma semana e verificar o aviso na tela de Sobrecarga.
7. Em debug, ligar **Simular falha de carregamento** nas Configurações, ver o erro no Calendário e desligar para recuperar.
8. Sair da conta, confirmar que as rotas internas pedem login e entrar novamente.
9. Aumentar o tamanho da fonte do Android e procurar overflows.


## Decisões e limitações
 
- **Assistente local, não LLM.** O chat usa regras sobre as atividades do calendário. Não há envio de dados a servidores.
- **Sobrecarga é uma regra simples:** mais de 3 atividades na mesma semana. Não é diagnóstico clínico nem de saúde mental.
- **Autenticação apenas de demonstração.** As contas ficam no aparelho, com SHA-256 + salt. Não há servidor, e **não deve ser usado em produção nem com dados sensíveis**. A recuperação de senha por código é um protótipo e não altera credenciais.
- **Sem isolamento por usuário.** Atividades, grupos e histórico do chat são compartilhados entre contas no mesmo aparelho.
- **Dados de demonstração em memória:** amigos, professores e planejamento semanal não persistem.
- **Banco com esquema simples:** as tabelas guardam cada registro como JSON (`id` + `json`). É prático para o escopo acadêmico, mas não permite consultas por coluna.
- **Sem notificações push:** os lembretes são preferências salvas, sem agendamento no sistema.
**Próximos passos possíveis:** isolar dados por usuário (com migração do banco), usar colunas reais no SQLite, persistir os módulos restantes, usar um algoritmo de hash lento (PBKDF2/argon2) e integrar um serviço de IA real.
---

## Equipe
 
| Integrante | Responsabilidades |
|---|---|
| `Bianca Battestin Gonçalves` | `Organização e acompanhamento das atividades da equipe, apoio na distribuição de tarefas, alinhamento do grupo e elaboração do README.` |
| `Henrique Gonçalves Mendonça` | `Produção e edição do vídeo de apresentação, participação na apresentação do projeto e contribuições com sugestões e opiniões sobre o código.` |
| `Nycolas Viera Rosa Soares` | `Produção e edição do vídeo de apresentação, participação na apresentação do projeto e contribuições com sugestões e opiniões sobre o código.` |
| `Rodrigo da Silva Poyatos` | `Desenvolvimento da aplicação, implementação de funcionalidades, ajustes e integração do código.` |
| `Rafaella Seara Cardoso` | `Desenvolvimento da aplicação, implementação de funcionalidades, ajustes e integração do código.` |

- Fluxo com *branches* por funcionalidade e *Pull Requests* revisados por outro integrante.
- Mensagens de commit descritivas, no estilo `feat:`, `fix:`, `test:`, `docs:`, `refactor:`.
- Antes de abrir um PR, execute `dart format .`, `flutter analyze` e `flutter test`.






