import 'package:plataforma_educacional/core/data/list_repository.dart';
import 'package:plataforma_educacional/features/teachers/models/teacher_preview.dart';

/// Futuro SQLite: crie outra implementação desta interface.
abstract interface class TeacherRepository
    implements ListRepository<TeacherPreview> {}
