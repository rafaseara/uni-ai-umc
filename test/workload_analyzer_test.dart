import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plataforma_educacional/core/models/priority.dart';
import 'package:plataforma_educacional/features/calendar/models/calendar_activity.dart';
import 'package:plataforma_educacional/features/workload/domain/workload_analyzer.dart';

CalendarActivity activity(int day) => CalendarActivity(
  id: 'test-$day',
  title: 'Atividade $day',
  description: '',
  date: DateTime(2026, 11, day),
  time: const TimeOfDay(hour: 14, minute: 0),
  priority: Priority.medium,
  duration: const Duration(hours: 1),
  reminder: false,
);

void main() {
  test('Começa na segunda-feira', () {
    expect(
      WorkloadAnalyzer.weekStartOf(DateTime(2026, 11, 12)),
      DateTime(2026, 11, 9),
    );
  });
  test('Quatro atividades na semana é sobrecarga, três não', () {
    final three = [activity(9), activity(10), activity(11)];
    expect(WorkloadAnalyzer.byWeek(three).single.overloaded, isFalse);
    expect(
      WorkloadAnalyzer.byWeek([...three, activity(12)]).single.overloaded,
      isTrue,
    );
    expect(WorkloadAnalyzer.byWeek([...three, activity(16)]), hasLength(2));
  });
}
