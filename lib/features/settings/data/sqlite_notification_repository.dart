import 'package:sqflite/sqflite.dart';
import 'package:plataforma_educacional/core/data/sqlite_store.dart';
import 'package:plataforma_educacional/features/settings/data/notification_repository.dart';
import 'package:plataforma_educacional/features/settings/models/reminder.dart';

class SqliteNotificationRepository extends SqliteStore<Reminder>
    implements NotificationRepository {
  SqliteNotificationRepository(Database db)
    : super(db, 'reminders', Reminder.fromJson, (item) => item.toJson());
}
