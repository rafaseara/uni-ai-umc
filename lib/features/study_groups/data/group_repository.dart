import 'package:plataforma_educacional/core/data/list_repository.dart';
import 'package:plataforma_educacional/features/study_groups/models/study_group.dart';

/// Futuro SQLite: crie outra implementação desta interface.
abstract interface class GroupRepository implements ListRepository<StudyGroup> {
  List<String> getSuggestedMembers();
}
