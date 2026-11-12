import 'package:sqflite/sqflite.dart';
import 'package:plataforma_educacional/core/data/sqlite_store.dart';
import 'package:plataforma_educacional/features/calendar/data/activity_repository.dart';
import 'package:plataforma_educacional/features/calendar/models/calendar_activity.dart';

class SqliteActivityRepository extends SqliteStore<CalendarActivity>
    implements ActivityRepository {
  SqliteActivityRepository(Database db)
    : super(
        db,
        'activities',
        CalendarActivity.fromJson,
        (item) => item.toJson(),
      );
}
