import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plataforma_educacional/features/settings/data/in_memory_notification_repository.dart';
import 'package:plataforma_educacional/features/settings/presentation/controllers/notification_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Preferências de notificação resistem a novo controller', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final first = NotificationController(
      InMemoryNotificationRepository(delay: Duration.zero),
      preferences: prefs,
    );
    first.setEnabled(2, false);
    // Aguarda o Future da gravação interna antes de criar nova instância.
    await Future<void>.delayed(const Duration(milliseconds: 1));
    final second = NotificationController(
      InMemoryNotificationRepository(delay: Duration.zero),
      preferences: prefs,
    );
    expect(second.enabled[2], isFalse);
    first.dispose();
    second.dispose();
  });
}
