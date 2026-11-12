import 'package:flutter/foundation.dart';

@immutable
class PlannerWeekDay {
  const PlannerWeekDay({required this.date, required this.hasActivity});
  final DateTime date;
  final bool hasActivity;
  String get weekday =>
      const ['S', 'T', 'Q', 'Q', 'S', 'S', 'D'][date.weekday - 1];
  String get day => '${date.day}';
}
