import 'package:plataforma_educacional/core/presentation/list_controller.dart';
import 'package:plataforma_educacional/features/calendar/data/activity_repository.dart';
import 'package:plataforma_educacional/features/calendar/models/calendar_activity.dart';

class ActivityController extends ListController<CalendarActivity> {
  ActivityController(ActivityRepository repository) : super(repository);
}
