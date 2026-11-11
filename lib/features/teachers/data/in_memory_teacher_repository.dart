import 'package:plataforma_educacional/core/data/in_memory_store.dart';
import 'package:plataforma_educacional/features/teachers/data/teacher_repository.dart';
import 'package:plataforma_educacional/features/teachers/models/teacher_preview.dart';

class InMemoryTeacherRepository extends InMemoryStore<TeacherPreview> implements TeacherRepository {
  InMemoryTeacherRepository({Duration delay = const Duration(milliseconds: 600)})
      : super([ const TeacherPreview(id: 'teacher-1', initials: 'AM', name: 'Ana Martins', subject: 'Algoritmos e programação'),
    const TeacherPreview(id: 'teacher-2', initials: 'RC', name: 'Rafael Costa', subject: 'Matemática e cálculo') ], delay: delay);
}
