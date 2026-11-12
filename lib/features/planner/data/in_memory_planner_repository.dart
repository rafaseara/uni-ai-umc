import 'package:plataforma_educacional/core/data/in_memory_store.dart';
import 'package:plataforma_educacional/core/models/priority.dart';
import 'package:plataforma_educacional/features/planner/data/planner_repository.dart';
import 'package:plataforma_educacional/features/planner/models/planner_activity.dart';

class InMemoryPlannerRepository extends InMemoryStore<PlannerActivity>
    implements PlannerRepository {
  InMemoryPlannerRepository({super.delay})
    : super([
        PlannerActivity(
          id: 'planner-1',
          title: 'Revisão de algoritmos',
          scheduledAt: DateTime(2026, 10, 29, 14),
          duration: const Duration(hours: 1),
          priority: Priority.high,
        ),
        PlannerActivity(
          id: 'planner-2',
          title: 'Resumo com o Chat IA',
          scheduledAt: DateTime(2026, 10, 29, 19),
          duration: const Duration(minutes: 30),
        ),
      ]);
}
