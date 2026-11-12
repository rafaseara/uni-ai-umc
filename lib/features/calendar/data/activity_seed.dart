import 'package:flutter/material.dart';
import 'package:plataforma_educacional/core/models/priority.dart';
import 'package:plataforma_educacional/features/calendar/models/calendar_activity.dart';

List<CalendarActivity> activitySeed() => [
  CalendarActivity(
    id: 'activity-1',
    title: 'Revisão de algoritmos',
    description: 'Estruturas de repetição · 1h de estudo',
    date: DateTime(2026, 10, 25),
    time: const TimeOfDay(hour: 14, minute: 0),
    priority: Priority.high,
    duration: const Duration(hours: 1),
    reminder: true,
  ),
];
