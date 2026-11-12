import 'package:plataforma_educacional/core/data/in_memory_store.dart';
import 'package:plataforma_educacional/features/calendar/data/activity_repository.dart';
import 'package:plataforma_educacional/features/calendar/data/activity_seed.dart';
import 'package:plataforma_educacional/features/calendar/models/calendar_activity.dart';

class InMemoryActivityRepository extends InMemoryStore<CalendarActivity>
    implements ActivityRepository {
  InMemoryActivityRepository({super.delay}) : super(activitySeed());
}
