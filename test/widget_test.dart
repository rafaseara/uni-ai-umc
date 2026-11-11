import 'package:flutter_test/flutter_test.dart';
import 'package:plataforma_educacional/features/auth/presentation/pages/welcome_page.dart';
import 'package:plataforma_educacional/main.dart';

void main() {
  testWidgets('Uni.A.I. inicia nas boas-vindas', (tester) async {
    await tester.pumpWidget(const UniAIApp());
    expect(find.byType(WelcomePage), findsOneWidget);
  });
}
