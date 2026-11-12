import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plataforma_educacional/core/data/flaky_repository.dart';
import 'package:plataforma_educacional/core/models/priority.dart';
import 'package:plataforma_educacional/core/presentation/list_controller.dart';
import 'package:plataforma_educacional/features/calendar/data/in_memory_activity_repository.dart';
import 'package:plataforma_educacional/features/calendar/models/calendar_activity.dart';
import 'package:plataforma_educacional/features/calendar/presentation/controllers/activity_controller.dart';

class _BrokenRepository extends InMemoryActivityRepository {
  _BrokenRepository() : super(delay: Duration.zero);
  @override
  Future<void> update(CalendarActivity item) =>
      Future.error(StateError('Falha de escrita'));
}

void main() {
  test('Mutação local não volta ao estado loading', () async {
    final controller = ActivityController(
      InMemoryActivityRepository(delay: Duration.zero),
    );
    await controller.load();
    final item = CalendarActivity(
      id: 'local-item',
      title: 'P1',
      description: '',
      date: DateTime(2026, 11, 12),
      time: const TimeOfDay(hour: 10, minute: 0),
      priority: Priority.low,
      duration: Duration.zero,
      reminder: false,
    );
    await controller.add(item);
    expect(controller.status, LoadStatus.ready);
    expect(controller.items.last.id, item.id);
    await controller.update(item.copyWith(title: 'P2'));
    expect(controller.items.last.title, 'P2');
    await controller.delete(item.id);
    expect(controller.items.where((e) => e.id == item.id), isEmpty);
    controller.dispose();
  });
  test('Falha de ação mantém itens e não esconde a lista', () async {
    final controller = ActivityController(_BrokenRepository());
    await controller.load();
    final before = controller.items.first.title;
    await controller.update(controller.items.first.copyWith(title: 'Novo'));
    expect(controller.status, LoadStatus.ready);
    expect(controller.items.first.title, before);
    expect(controller.actionError, isNotNull);
    expect(controller.error, isNull);
    controller.dispose();
  });
  test('FaultSwitch simula apenas falha de carregamento', () async {
    final controller = ActivityController(
      FlakyActivityRepository(InMemoryActivityRepository(delay: Duration.zero)),
    );
    FaultSwitch.enabled.value = true;
    await controller.load();
    expect(controller.status, LoadStatus.error);
    FaultSwitch.enabled.value = false;
    await controller.load();
    expect(controller.status, LoadStatus.ready);
    controller.dispose();
  });
}
