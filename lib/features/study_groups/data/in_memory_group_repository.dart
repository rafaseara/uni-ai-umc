import 'package:plataforma_educacional/core/data/in_memory_store.dart';
import 'package:plataforma_educacional/features/study_groups/data/group_repository.dart';
import 'package:plataforma_educacional/features/study_groups/data/group_seed.dart';
import 'package:plataforma_educacional/features/study_groups/models/study_group.dart';

class InMemoryGroupRepository extends InMemoryStore<StudyGroup>
    implements GroupRepository {
  InMemoryGroupRepository({super.delay}) : super(groupSeed());

  @override
  List<String> getSuggestedMembers() => suggestedGroupMembers;
}
