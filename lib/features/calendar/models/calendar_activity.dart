import 'package:flutter/material.dart';
import 'package:plataforma_educacional/core/models/identified.dart';
import 'package:plataforma_educacional/core/models/priority.dart';

@immutable
class CalendarActivity implements Identified {
  const CalendarActivity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.priority,
    required this.duration,
    required this.reminder,
  });

  @override
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay time;
  final Priority priority;
  final Duration duration;
  final bool reminder;

  Map<String, Object?> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'date': date.toIso8601String(),
    'hour': time.hour,
    'minute': time.minute,
    'priority': priority.name,
    'durationMinutes': duration.inMinutes,
    'reminder': reminder,
  };

  factory CalendarActivity.fromJson(Map<String, Object?> data) =>
      CalendarActivity(
        id: data['id'] as String,
        title: data['title'] as String,
        description: data['description'] as String,
        date: DateTime.parse(data['date'] as String),
        time: TimeOfDay(
          hour: (data['hour'] as num).toInt(),
          minute: (data['minute'] as num).toInt(),
        ),
        priority: Priority.values.byName(data['priority'] as String),
        duration: Duration(minutes: (data['durationMinutes'] as num).toInt()),
        reminder: data['reminder'] as bool,
      );

  String get timeLabel =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  String get priorityLabel => priority.label;
  String get durationLabel => switch (duration.inMinutes) {
    0 => '0 hora',
    30 => '30 minutos',
    60 => '1 hora',
    120 => '2 horas',
    180 => '3 horas',
    final minutes => '$minutes minutos',
  };

  CalendarActivity copyWith({
    String? title,
    String? description,
    DateTime? date,
    TimeOfDay? time,
    Priority? priority,
    Duration? duration,
    bool? reminder,
  }) => CalendarActivity(
    id: id,
    title: title ?? this.title,
    description: description ?? this.description,
    date: date ?? this.date,
    time: time ?? this.time,
    priority: priority ?? this.priority,
    duration: duration ?? this.duration,
    reminder: reminder ?? this.reminder,
  );
}
