import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:plataforma_educacional/core/models/identified.dart';

@immutable
class Reminder implements Identified {
  const Reminder({
    required this.id,
    required this.title,
    required this.scheduledAt,
  });
  @override
  final String id;
  final String title;
  final DateTime scheduledAt;
  Map<String, Object?> toJson() => {
    'id': id,
    'title': title,
    'scheduledAt': scheduledAt.toIso8601String(),
  };

  factory Reminder.fromJson(Map<String, Object?> data) => Reminder(
    id: data['id'] as String,
    title: data['title'] as String,
    scheduledAt: DateTime.parse(data['scheduledAt'] as String),
  );

  String get time =>
      '${DateFormat('dd/MM/yyyy').format(scheduledAt)} · ${DateFormat('HH:mm').format(scheduledAt)}';
}
