import 'package:plataforma_educacional/core/data/in_memory_store.dart';
import 'package:plataforma_educacional/features/settings/data/notification_repository.dart';
import 'package:plataforma_educacional/features/settings/models/reminder.dart';

class InMemoryNotificationRepository extends InMemoryStore<Reminder> implements NotificationRepository {
  InMemoryNotificationRepository({Duration delay = const Duration(milliseconds: 600)})
      : super([ Reminder(id: 'reminder-1', title: 'Entregar trabalho de Engenharia', scheduledAt: DateTime(2026, 10, 29, 18)),
    Reminder(id: 'reminder-2', title: 'Horário de estudo', scheduledAt: DateTime(2026, 10, 29, 19)),
    Reminder(id: 'reminder-3', title: 'Pausa para descanso', scheduledAt: DateTime(2026, 10, 29, 19, 50)) ], delay: delay);
}
