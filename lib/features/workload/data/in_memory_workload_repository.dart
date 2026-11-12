import 'package:plataforma_educacional/core/data/in_memory_store.dart';
import 'package:plataforma_educacional/features/workload/data/workload_repository.dart';
import 'package:plataforma_educacional/features/workload/models/workload_task.dart';

class InMemoryWorkloadRepository extends InMemoryStore<WorkloadTask>
    implements WorkloadRepository {
  InMemoryWorkloadRepository({super.delay})
    : super([
        const WorkloadTask(id: 'task-1', nearDeadline: true),
        const WorkloadTask(id: 'task-2', nearDeadline: true),
        const WorkloadTask(id: 'task-3', nearDeadline: true),
        const WorkloadTask(id: 'task-4', nearDeadline: true),
        const WorkloadTask(id: 'task-5', nearDeadline: true),
        const WorkloadTask(id: 'task-6', nearDeadline: false),
        const WorkloadTask(id: 'task-7', nearDeadline: false),
        const WorkloadTask(id: 'task-8', nearDeadline: false),
        const WorkloadTask(id: 'task-9', nearDeadline: false),
        const WorkloadTask(id: 'task-10', nearDeadline: false),
        const WorkloadTask(id: 'task-11', nearDeadline: false),
        const WorkloadTask(id: 'task-12', nearDeadline: false),
      ]);
}
