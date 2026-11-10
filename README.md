# uni-ai-umc
Aplicativo Flutter de apoio acadêmico com IA: organiza atividades, prazos e rotina de estudos para universitários. Projeto da UMC 2026.

# Sobre o projeto

O Uni.A.I é uma aplicação desenvolvida com o objetivo de auxiliar estudantes na organização da rotina acadêmica, promovendo a colaboração entre alunos e contribuindo para o equilíbrio das atividades de estudo.
A plataforma utiliza inteligência artificial para integrar ferramentas de planejamento, organização e colaboração em um único ambiente, facilitando o gerenciamento de tarefas, provas, trabalhos e compromissos acadêmicos.

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

As tecnologias definidas para o desenvolvimento da plataforma são:
| Tecnologia | Aplicação | 
| :--- | :---: |
| Flutter | Desenvolvimento da interface do aplicativo| 
| Dart | Linguagem de programação do aplicativo | 
| Python | Desenvolvimento do backend e integração com IA |
| FastAPI | Construção da API REST |
|  MySQL | Gerenciamento do banco de dados |
| API de modelo de linguagem | Integração dos recursos de inteligência artificial|
| Git e GitHub | Versionamento e colaboração no desenvolvimento |


# Como executar o projeto
**Pré-requisitos**

Antes de executar o projeto, é necessário possuir:

- Flutter SDK instalado.
- Dart SDK instalado.
- Python instalado.
- MySQL instalado e configurado.
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

# 3. Executar o backend

Acesse a pasta do backend e crie um ambiente virtual:

```text
python -m venv venv
```
Ative o ambiente virtual.

Windows:

```text
venv\Scripts\activate
```
Instale as dependências:

```text
pip install -r requirements.txt
```

Inicie a API:
```text
uvicorn app.main:app --reload
```



**Observação:** os caminhos e comandos de execução deverão corresponder à estrutura real do repositório. A configuração do banco MySQL e das variáveis de ambiente também deverá ser documentada conforme a implementação.


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


