import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:plataforma_educacional/core/models/priority.dart';
import 'package:plataforma_educacional/features/calendar/models/calendar_activity.dart';
import 'package:plataforma_educacional/features/ai_chat/domain/local_assistant.dart';

void main() {
  setUpAll(() => initializeDateFormatting('pt_BR'));
  final assistant = LocalAssistant();
  final now = DateTime(2026, 11, 12);
  final example = CalendarActivity(
    id: 'activity-2',
    title: 'Prova de banco de dados',
    description: '',
    date: DateTime(2026, 11, 13),
    time: const TimeOfDay(hour: 19, minute: 0),
    priority: Priority.high,
    duration: const Duration(hours: 1),
    reminder: false,
  );

  test('Semana vazia', () {
    expect(
      assistant.reply('o que vence esta semana?', [], now),
      contains('não tem atividades'),
    );
  });
  test('Lista atividades da semana', () {
    final answer = assistant.reply('o que vence esta semana?', [example], now);
    expect(answer, contains('13/11/2026'));
    expect(answer, contains('Prova de banco de dados'));
  });
  test('Pergunta fora do escopo recebe ajuda apropriada', () {
    expect(
      assistant.reply('qual a capital da Austrália?', [], now),
      contains('assistente local'),
    );
  });
}
