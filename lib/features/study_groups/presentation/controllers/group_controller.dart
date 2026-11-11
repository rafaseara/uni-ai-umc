import 'package:plataforma_educacional/core/presentation/list_controller.dart';
import 'package:plataforma_educacional/features/study_groups/data/group_repository.dart';
import 'package:plataforma_educacional/features/study_groups/models/study_group.dart';

class GroupController extends ListController<StudyGroup> {
  GroupController(this._groupRepository) : super(_groupRepository);
  final GroupRepository _groupRepository;
  List<String> get suggestedMembers => _groupRepository.getSuggestedMembers();
}
