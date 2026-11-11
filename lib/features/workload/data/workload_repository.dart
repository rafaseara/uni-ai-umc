import 'package:plataforma_educacional/core/data/list_repository.dart';
import 'package:plataforma_educacional/features/workload/models/workload_task.dart';

/// Futuro SQLite: crie outra implementação desta interface.
abstract interface class WorkloadRepository implements ListRepository<WorkloadTask> {}
