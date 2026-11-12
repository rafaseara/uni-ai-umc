import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/features/auth/presentation/controllers/auth_controller.dart';
import 'package:plataforma_educacional/features/auth/presentation/pages/login_page.dart';
import 'package:plataforma_educacional/features/home/presentation/pages/home_page.dart';
import 'package:plataforma_educacional/main.dart';
import 'package:plataforma_educacional/shared/widgets/uni_bottom_nav.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('pt_BR');
  });

  testWidgets('Login valida credenciais locais e navega para Home', (
    tester,
  ) async {
    final auth = AuthController();
    await auth.register('Aluno Teste', 'aluno@universidade.com', 'senha123');
    await auth.signOut();
    await tester.pumpWidget(UniAiApp(authController: auth));
    await tester.tap(find.text('ENTRAR'));
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);
    await tester.tap(find.text('ENTRAR'));
    await tester.pump();
    expect(find.text('Informe seu e-mail.'), findsOneWidget);
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'aluno@universidade.com');
    await tester.enterText(fields.at(1), 'senha123');
    await tester.tap(find.text('ENTRAR'));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(UniBottomNav), findsOneWidget);
    final context = tester.element(find.byType(HomePage));
    expect(context.read<AuthController>().signedIn, isTrue);
  });

  testWidgets('Abas preservam o controller ao navegar', (tester) async {
    final auth = AuthController();
    await auth.register('Aluno Teste', 'aluno@universidade.com', 'senha123');
    await tester.pumpWidget(UniAiApp(authController: auth));
    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    navigator.pushNamedAndRemoveUntil(AppRoutes.home, (_) => false);
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: find.byType(UniBottomNav),
        matching: find.text('Grupos'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(UniBottomNav), findsOneWidget);
    await tester.tap(
      find.descendant(
        of: find.byType(UniBottomNav),
        matching: find.text('Início'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
  });
}
