import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/core/data/in_memory_store.dart';
import 'package:plataforma_educacional/features/calendar/data/activity_repository.dart';
import 'package:plataforma_educacional/features/calendar/data/in_memory_activity_repository.dart';
import 'package:plataforma_educacional/features/calendar/models/calendar_activity.dart';
import 'package:plataforma_educacional/features/calendar/presentation/controllers/activity_controller.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:plataforma_educacional/shared/uni_validators.dart';
import 'package:plataforma_educacional/shared/widgets/uni_controlled_list.dart';
import 'package:plataforma_educacional/shared/widgets/uni_empty_state.dart';
import 'package:plataforma_educacional/shared/widgets/uni_error_state.dart';
import 'package:plataforma_educacional/shared/widgets/uni_loading.dart';

class _EmptyRepository extends InMemoryStore<CalendarActivity>
    implements ActivityRepository {
  _EmptyRepository() : super([], delay: Duration.zero);
}

class _RetryRepository extends _EmptyRepository {
  var attempts = 0;
  @override
  Future<List<CalendarActivity>> getAll() async {
    attempts++;
    if (attempts == 1) throw StateError('Falha simulada');
    return super.getAll();
  }
}

Widget _wrapped(ActivityController controller) => ChangeNotifierProvider.value(
  value: controller,
  child: MaterialApp(
    home: Scaffold(
      body: Builder(
        builder: (context) => UniControlledList<CalendarActivity>(
          controller: context.watch<ActivityController>(),
          emptyState: const UniEmptyState(
            icon: Icons.search_off,
            title: 'Lista vazia',
            message: 'Sem resultados no momento.',
          ),
          builder: (context, activities) => Text('Total: ${activities.length}'),
        ),
      ),
    ),
  ),
);

void main() {
  test('Validações são específicas e não aceitam entrada inválida', () {
    expect(UniValidators.email('nao-e-email'), isNotNull);
    expect(UniValidators.email('aluno@universidade.com'), isNull);
    expect(UniValidators.birthDate('31/02/2009'), isNotNull);
    expect(UniValidators.birthDate('15/10/2009'), isNull);
    expect(UniValidators.password('123'), isNotNull);
    expect(UniValidators.confirmPassword('abc123', 'abc124'), isNotNull);
    expect(UniValidators.confirmPassword('abc123', 'abc123'), isNull);
  });

  testWidgets('AuthTextField exibe erro no próprio campo', (tester) async {
    final formKey = GlobalKey<FormState>();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: AuthTextField(
              hint: 'voce@email.com',
              validator: UniValidators.email,
            ),
          ),
        ),
      ),
    );
    expect(formKey.currentState!.validate(), isFalse);
    await tester.pump();
    expect(find.text('Informe seu e-mail.'), findsOneWidget);
  });

  testWidgets('Controller mostra loading e depois resultado', (tester) async {
    final controller = ActivityController(InMemoryActivityRepository());
    await tester.pumpWidget(_wrapped(controller));
    expect(find.byType(UniLoading), findsOneWidget);
    final pending = controller.load();
    await tester.pump();
    expect(find.byType(UniLoading), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 600));
    await pending;
    await tester.pump();
    expect(find.text('Total: 1'), findsOneWidget);
  });

  testWidgets('Lista vazia informa o motivo', (tester) async {
    final controller = ActivityController(_EmptyRepository());

    await tester.pumpWidget(_wrapped(controller));

    final pending = controller.load();

    await tester.pump(const Duration(milliseconds: 1));
    await pending;
    await tester.pump();

    expect(find.text('Lista vazia'), findsOneWidget);
  });
  testWidgets('Falha mostra tentar novamente e permite recuperação', (
    tester,
  ) async {
    final repo = _RetryRepository();
    final controller = ActivityController(repo);
    await tester.pumpWidget(_wrapped(controller));
    await controller.load();
    await tester.pump();
    expect(find.byType(UniErrorState), findsOneWidget);
    await tester.tap(find.text('Tentar novamente'));
    await tester.pumpAndSettle();
    expect(find.text('Lista vazia'), findsOneWidget);
    expect(repo.attempts, 2);
  });
}
