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
  }) : members = List.unmodifiable(members),
       materials = List.unmodifiable(materials);

  @override
  final String id;
  final String name;
  final String description;
  final List<String> members;
  final String nextActivity;
  final DateTime? nextActivityAt;
  final List<String> materials;

  Map<String, Object?> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'members': members,
    'nextActivity': nextActivity,
    'nextActivityAt': nextActivityAt?.toIso8601String(),
    'materials': materials,
  };

  factory StudyGroup.fromJson(Map<String, Object?> data) => StudyGroup(
    id: data['id'] as String,
    name: data['name'] as String,
    description: data['description'] as String,
    members: (data['members'] as List<dynamic>).cast<String>(),
    nextActivity: data['nextActivity'] as String,
    nextActivityAt: data['nextActivityAt'] == null
        ? null
        : DateTime.parse(data['nextActivityAt'] as String),
    materials: (data['materials'] as List<dynamic>).cast<String>(),
  );

  String get activityDate => nextActivityAt == null
      ? (nextActivity == 'Nenhuma atividade cadastrada'
            ? ''
            : 'Data não definida')
      : '${DateFormat("d 'de' MMMM", 'pt_BR').format(nextActivityAt!)} · ${DateFormat('HH', 'pt_BR').format(nextActivityAt!)}h';

  StudyGroup copyWith({
    String? name,
    String? description,
    List<String>? members,
    String? nextActivity,
    DateTime? nextActivityAt,
    List<String>? materials,
    bool resetActivityDate = false,
  }) => StudyGroup(
    id: id,
    name: name ?? this.name,
    description: description ?? this.description,
    members: members ?? this.members,
    nextActivity: nextActivity ?? this.nextActivity,
    nextActivityAt: resetActivityDate
        ? null
        : (nextActivityAt ?? this.nextActivityAt),
    materials: materials ?? this.materials,
  );
}
