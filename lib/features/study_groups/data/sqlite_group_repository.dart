import 'package:sqflite/sqflite.dart';
import 'package:plataforma_educacional/core/data/sqlite_store.dart';
import 'package:plataforma_educacional/features/study_groups/data/group_repository.dart';
import 'package:plataforma_educacional/features/study_groups/data/group_seed.dart';
import 'package:plataforma_educacional/features/study_groups/models/study_group.dart';

class SqliteGroupRepository extends SqliteStore<StudyGroup>
    implements GroupRepository {
  SqliteGroupRepository(Database db)
    : super(db, 'study_groups', StudyGroup.fromJson, (item) => item.toJson());

  @override
  List<String> getSuggestedMembers() => suggestedGroupMembers;
}
