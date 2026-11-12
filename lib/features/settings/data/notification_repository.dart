import 'package:plataforma_educacional/core/data/list_repository.dart';
import 'package:plataforma_educacional/features/settings/models/reminder.dart';

/// Futuro SQLite: crie outra implementação desta interface.
abstract interface class NotificationRepository
    implements ListRepository<Reminder> {}
