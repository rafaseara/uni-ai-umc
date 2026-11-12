import 'package:plataforma_educacional/features/calendar/models/calendar_activity.dart';

class WeekLoad {
  const WeekLoad(this.weekStart, this.count);
  final DateTime weekStart;
  final int count;
  bool get overloaded => count > 3;
}

/// Contagem determinística por semana civil (segunda a domingo).
class WorkloadAnalyzer {
  WorkloadAnalyzer._();

  static DateTime weekStartOf(DateTime day) {
    final date = DateTime(day.year, day.month, day.day);
    return date.subtract(Duration(days: date.weekday - DateTime.monday));
  }

  static List<WeekLoad> byWeek(List<CalendarActivity> activities) {
    final counts = <DateTime, int>{};
    for (final activity in activities) {
      final monday = weekStartOf(activity.date);
      counts[monday] = (counts[monday] ?? 0) + 1;
    }
    final entries = counts.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    return [for (final e in entries) WeekLoad(e.key, e.value)];
  }
}
