import 'package:plataforma_educacional/core/data/in_memory_store.dart';
import 'package:plataforma_educacional/features/study_groups/data/group_repository.dart';
import 'package:plataforma_educacional/features/study_groups/models/study_group.dart';

class InMemoryGroupRepository extends InMemoryStore<StudyGroup> implements GroupRepository {
  InMemoryGroupRepository({Duration delay = const Duration(milliseconds: 600)})
      : super([ StudyGroup(id: 'group-1', name: 'Algoritmos em equipe',
      description: 'Compartilhando conhecimento e projetos',
      members: const ['João Miguel', 'Beatriz Santos', 'Gabriel Fernandes'],
      nextActivity: 'Revisão de estruturas de repetição',
      nextActivityAt: DateTime(2026, 10, 27, 19), materials: const ['Resumo de Algoritmos']),
    StudyGroup(id: 'group-2', name: 'Cálculo sem limites',
      description: 'Estudando cálculo em conjunto',
      members: const ['João Miguel', 'Beatriz Santos', 'Arthur Ferreira'],
      nextActivity: 'Entrega da lista de exercícios',
      nextActivityAt: DateTime(2026, 10, 28, 20), materials: const ['Lista de exercícios 04']) ], delay: delay);
  @override
  List<String> getSuggestedMembers() => const [
    'João Miguel', 'Beatriz Santos', 'Gabriel Fernandes',
    'Arthur Ferreira', 'Maria Júlia',
  ];
}
