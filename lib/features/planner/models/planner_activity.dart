import 'package:flutter/foundation.dart';
import 'package:plataforma_educacional/core/models/identified.dart';
import 'package:plataforma_educacional/core/models/priority.dart';

@immutable
class PlannerActivity implements Identified {
  const PlannerActivity({required this.id, required this.title,
    required this.scheduledAt, required this.duration, this.priority});
  @override
  final String id;
  final String title;
  final DateTime scheduledAt;
  final Duration duration;
  final Priority? priority;
  String get details => '${scheduledAt.hour}h · ${duration.inMinutes == 60 ? '1 hora' : '${duration.inMinutes} min'}';
  String? get tag => priority == Priority.high ? 'Alta prioridade' : null;
}
