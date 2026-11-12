import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:plataforma_educacional/core/models/priority.dart';
import 'package:plataforma_educacional/core/presentation/list_controller.dart';
import 'package:plataforma_educacional/features/auth/presentation/controllers/auth_controller.dart';
import 'package:plataforma_educacional/features/auth/data/in_memory_user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plataforma_educacional/features/calendar/data/in_memory_activity_repository.dart';
import 'package:plataforma_educacional/features/calendar/models/calendar_activity.dart';
import 'package:plataforma_educacional/features/calendar/presentation/controllers/activity_controller.dart';
import 'package:plataforma_educacional/features/friends/data/in_memory_friend_repository.dart';
import 'package:plataforma_educacional/features/friends/presentation/controllers/friend_controller.dart';
import 'package:plataforma_educacional/features/planner/data/in_memory_planner_repository.dart';
import 'package:plataforma_educacional/features/planner/presentation/controllers/planner_controller.dart';
import 'package:plataforma_educacional/features/settings/data/in_memory_notification_repository.dart';
import 'package:plataforma_educacional/features/settings/presentation/controllers/notification_controller.dart';
import 'package:plataforma_educacional/features/study_groups/data/in_memory_group_repository.dart';
import 'package:plataforma_educacional/features/study_groups/presentation/controllers/group_controller.dart';
import 'package:plataforma_educacional/features/teachers/data/in_memory_teacher_repository.dart';
import 'package:plataforma_educacional/features/teachers/models/teacher_preview.dart';
import 'package:plataforma_educacional/features/teachers/presentation/controllers/teacher_controller.dart';
import 'package:plataforma_educacional/features/workload/data/in_memory_workload_repository.dart';
import 'package:plataforma_educacional/features/workload/presentation/controllers/workload_controller.dart';

class _FailOnceRepository extends InMemoryActivityRepository {
  _FailOnceRepository() : super(delay: Duration.zero);
  bool shouldFail = true;
  @override
  Future<List<CalendarActivity>> getAll() async {
    if (shouldFail) {
      shouldFail = false;
      throw StateError('Falha simulada');
    }
    return super.getAll();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    await initializeDateFormatting('pt_BR');
  });

  test(
    'ActivityController: carregar, criar, editar e excluir na mesma sessão',
    () async {
      final repository = InMemoryActivityRepository(delay: Duration.zero);
      final controller = ActivityController(repository);
      await controller.load();
      expect(controller.status, LoadStatus.ready);
      expect(controller.items, hasLength(1));
      final newActivity = CalendarActivity(
        id: 'new-1',
        title: 'Novo estudo',
        description: 'Revisão',
        date: DateTime(2026, 11, 11),
        time: const TimeOfDay(hour: 16, minute: 30),
        priority: Priority.medium,
        duration: const Duration(hours: 1),
        reminder: false,
      );
      await controller.add(newActivity);
      expect(controller.items, hasLength(2));
      await controller.update(
        newActivity.copyWith(title: 'Novo estudo atualizado'),
      );
      expect(controller.items.last.title, 'Novo estudo atualizado');
      final secondController = ActivityController(repository);
      await secondController.load();
      expect(secondController.items.last.title, 'Novo estudo atualizado');
      await controller.delete('new-1');
      expect(controller.items, hasLength(1));
      controller.dispose();
      secondController.dispose();
    },
  );

  test('ActivityController: erro e nova tentativa', () async {
    final controller = ActivityController(_FailOnceRepository());
    await controller.load();
    expect(controller.status, LoadStatus.error);
    await controller.load();
    expect(controller.status, LoadStatus.ready);
    controller.dispose();
  });

  test(
    'GroupController: material persiste após reload e listas são imutáveis',
    () async {
      final repository = InMemoryGroupRepository(delay: Duration.zero);
      final controller = GroupController(repository);
      await controller.load();
      final first = controller.items.first;
      await controller.update(
        first.copyWith(materials: [...first.materials, 'Documento teste']),
      );
      final newController = GroupController(repository);
      await newController.load();
      expect(newController.items.first.materials, contains('Documento teste'));
      expect(
        () => newController.items.first.members.add('Teste'),
        throwsUnsupportedError,
      );
      controller.dispose();
      newController.dispose();
    },
  );

  test('FriendController: lista e busca por nome', () async {
    final controller = FriendController(
      InMemoryFriendRepository(delay: Duration.zero),
    );
    await controller.load();
    expect(controller.items, hasLength(5));
    await controller.search('Fernando');
    expect(controller.searchResults.single.initials, 'FL');
    await controller.search('Inexistente');
    expect(controller.searchResults, isEmpty);
    expect(controller.searchStatus, LoadStatus.ready);
    controller.dispose();
  });

  test('TeacherController: atualizar item sem dependência de UI', () async {
    final controller = TeacherController(
      InMemoryTeacherRepository(delay: Duration.zero),
    );
    await controller.load();
    final item = controller.items.first;
    await controller.update(
      TeacherPreview(
        id: item.id,
        initials: item.initials,
        name: item.name,
        subject: 'Lógica de programação',
      ),
    );
    expect(controller.items.first.subject, 'Lógica de programação');
    controller.dispose();
  });

  test('PlannerController: atividades e sugestão persistem ao reutilizar instância', () async {
    final controller = PlannerController(
      InMemoryPlannerRepository(delay: Duration.zero),
    );
    await controller.load();
    expect(controller.items, hasLength(2));
    expect(controller.suggestionAccepted, isFalse);
    controller.acceptSuggestion();
    expect(controller.suggestionAccepted, isTrue);
    controller.dispose();
  });

  test('WorkloadController: números vêm do repositório', () async {
    final controller = WorkloadController(
      InMemoryWorkloadRepository(delay: Duration.zero),
    );
    await controller.load();
    expect(controller.items.length, 12);
    expect(controller.items.where((task) => task.nearDeadline).length, 5);
    controller.dispose();
  });

  test(
    'NotificationController: lembretes e switches persistem em memória',
    () async {
      final controller = NotificationController(
        InMemoryNotificationRepository(delay: Duration.zero),
      );
      await controller.load();
      expect(controller.items, hasLength(3));
      controller.setEnabled(1, false);
      expect(controller.enabled[1], isFalse);
      expect(controller.items.first.scheduledAt.hour, 18);
      controller.dispose();
    },
  );

  test(
    'AuthController: registro local, senha, duplicação, sessão e saída',
    () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final users = InMemoryUserRepository();
      final controller = AuthController(
        userRepository: users,
        preferences: prefs,
      );
      expect(controller.signedIn, isFalse);
      expect(
        await controller.register('Ana Silva', 'ANA@faculdade.com', 'senha123'),
        isTrue,
      );
      expect(controller.studentName, 'Ana Silva');
      expect(controller.initials, 'AS');
      expect(
        await controller.register('Outro', 'ana@faculdade.com', 'senha123'),
        isFalse,
      );
      expect(controller.lastError, 'E-mail já cadastrado.');
      final restored = AuthController(
        userRepository: users,
        preferences: prefs,
      );
      await restored.restoreSession();
      expect(restored.signedIn, isTrue);
      await restored.signOut();
      expect(restored.signedIn, isFalse);
      expect(await restored.login('ana@faculdade.com', 'errada'), isFalse);
      expect(restored.lastError, 'E-mail ou senha incorretos.');
      expect(await restored.login('ana@faculdade.com', 'senha123'), isTrue);
      controller.dispose();
      restored.dispose();
    },
  );
}
