import 'package:flutter/foundation.dart';
import 'package:plataforma_educacional/core/models/identified.dart';

@immutable
class TeacherPreview implements Identified {
  const TeacherPreview({
    required this.id,
    required this.initials,
    required this.name,
    required this.subject,
  });
  @override
  final String id;
  final String initials;
  final String name;
  final String subject;
}
