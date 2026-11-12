import 'package:plataforma_educacional/core/presentation/list_controller.dart';
import 'package:plataforma_educacional/features/teachers/data/teacher_repository.dart';
import 'package:plataforma_educacional/features/teachers/models/teacher_preview.dart';

class TeacherController extends ListController<TeacherPreview> {
  TeacherController(TeacherRepository super.repository);
}
