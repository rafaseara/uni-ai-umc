import 'package:plataforma_educacional/core/data/in_memory_store.dart';
import 'package:plataforma_educacional/features/settings/data/notification_repository.dart';
import 'package:plataforma_educacional/features/settings/data/reminder_seed.dart';
import 'package:plataforma_educacional/features/settings/models/reminder.dart';

class InMemoryNotificationRepository extends InMemoryStore<Reminder>
    implements NotificationRepository {
  InMemoryNotificationRepository({super.delay}) : super(reminderSeed());
}
