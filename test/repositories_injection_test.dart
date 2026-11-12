import 'package:flutter_test/flutter_test.dart';
import 'package:plataforma_educacional/core/di/app_providers.dart';
import 'package:plataforma_educacional/features/calendar/data/in_memory_activity_repository.dart';
import 'package:plataforma_educacional/features/calendar/presentation/controllers/activity_controller.dart';

void main() {
  test('AppRepositories aceita fake sem mudar controller', () async {
    final fake = InMemoryActivityRepository(delay: Duration.zero);
    final repositories = AppRepositories(activities: fake);
    final controller = ActivityController(repositories.activities);
    await controller.load();
    expect(controller.items, hasLength(1));
    controller.dispose();
  });
}
