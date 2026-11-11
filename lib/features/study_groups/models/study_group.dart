class StudyGroup {
  final String name;
  final String description;
  final List<String> members;
  final String nextActivity;
  final String activityDate;
  final List<String> materials;

  const StudyGroup({
    required this.name,
    required this.description,
    required this.members,
    required this.nextActivity,
    required this.activityDate,
    required this.materials,
  });

  StudyGroup copyWith({
    String? name,
    String? description,
    List<String>? members,
    String? nextActivity,
    String? activityDate,
    List<String>? materials,
  }) {
    return StudyGroup(
      name: name ?? this.name,
      description: description ?? this.description,
      members: members ?? this.members,
      nextActivity: nextActivity ?? this.nextActivity,
      activityDate: activityDate ?? this.activityDate,
      materials: materials ?? this.materials,
    );
  }
}
