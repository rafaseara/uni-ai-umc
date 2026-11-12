import 'package:flutter/foundation.dart';
import 'package:plataforma_educacional/core/models/identified.dart';

@immutable
class WorkloadTask implements Identified {
  const WorkloadTask({
    required this.id,
    required this.nearDeadline,
    this.dueAt,
  });
  @override
  final String id;
  final bool nearDeadline;
  final DateTime? dueAt;
}
