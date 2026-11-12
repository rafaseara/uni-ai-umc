import 'package:plataforma_educacional/features/settings/models/reminder.dart';

List<Reminder> reminderSeed() => [
  Reminder(
    id: 'reminder-1',
    title: 'Entregar trabalho de Engenharia',
    scheduledAt: DateTime(2026, 10, 29, 18),
  ),
  Reminder(
    id: 'reminder-2',
    title: 'Horário de estudo',
    scheduledAt: DateTime(2026, 10, 29, 19),
  ),
  Reminder(
    id: 'reminder-3',
    title: 'Pausa para descanso',
    scheduledAt: DateTime(2026, 10, 29, 19, 50),
  ),
];
