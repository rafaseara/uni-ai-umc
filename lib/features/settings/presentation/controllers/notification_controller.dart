import 'package:plataforma_educacional/core/presentation/list_controller.dart';
import 'package:plataforma_educacional/features/settings/data/notification_repository.dart';
import 'package:plataforma_educacional/features/settings/models/reminder.dart';

class NotificationController extends ListController<Reminder> {
  NotificationController(NotificationRepository repository) : super(repository);

  final List<bool> _enabled = [true, true, true, true];
  List<bool> get enabled => List<bool>.unmodifiable(_enabled);
  void setEnabled(int index, bool value) {
    _enabled[index] = value;
    notifyListeners();
  }
}
