import 'package:plataforma_educacional/core/presentation/list_controller.dart';
import 'package:plataforma_educacional/features/workload/data/workload_repository.dart';
import 'package:plataforma_educacional/features/workload/models/workload_task.dart';

class WorkloadController extends ListController<WorkloadTask> {
  WorkloadController(WorkloadRepository repository) : super(repository);
}
