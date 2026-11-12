import 'package:plataforma_educacional/core/presentation/list_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plataforma_educacional/features/settings/data/notification_repository.dart';
import 'package:plataforma_educacional/features/settings/models/reminder.dart';

class NotificationController extends ListController<Reminder> {
  NotificationController(
    NotificationRepository super.repository, {
    this._preferences,
  }) {
    if (_preferences != null) {
      for (var i = 0; i < _enabled.length; i++) {
        _enabled[i] = _preferences.getBool('notification_enabled_$i') ?? true;
      }
    }
  }
  final SharedPreferences? _preferences;

  final List<bool> _enabled = [true, true, true, true];
  List<bool> get enabled => List<bool>.unmodifiable(_enabled);
  void setEnabled(int index, bool value) {
    if (index < 0 || index >= _enabled.length) {
      throw RangeError.index(index, _enabled);
    }
    _enabled[index] = value;
    _preferences?.setBool('notification_enabled_$index', value);
    notifyListeners();
  }
}
