import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:plataforma_educacional/core/models/identified.dart';

@immutable
class StudyGroup implements Identified {
  StudyGroup({
    required this.id,
    required this.name,
    required this.description,
    required List<String> members,
    required this.nextActivity,
    required this.nextActivityAt,
    required List<String> materials,
  }) : members = List.unmodifiable(members), materials = List.unmodifiable(materials);

  @override
  final String id;
  final String name;
  final String description;
  final List<String> members;
  final String nextActivity;
  final DateTime? nextActivityAt;
  final List<String> materials;

  String get activityDate => nextActivityAt == null
      ? (nextActivity == 'Nenhuma atividade cadastrada' ? '' : 'Data não definida')
      : '${DateFormat("d 'de' MMMM", 'pt_BR').format(nextActivityAt!)} · ${DateFormat('HH', 'pt_BR').format(nextActivityAt!)}h';

  StudyGroup copyWith({String? name, String? description, List<String>? members,
      String? nextActivity, DateTime? nextActivityAt, List<String>? materials,
      bool resetActivityDate = false}) =>
    StudyGroup(
      id: id, name: name ?? this.name, description: description ?? this.description,
      members: members ?? this.members, nextActivity: nextActivity ?? this.nextActivity,
      nextActivityAt: resetActivityDate ? null : (nextActivityAt ?? this.nextActivityAt),
      materials: materials ?? this.materials,
    );
}
