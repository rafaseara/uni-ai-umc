import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/core/theme/app_theme.dart';
import 'package:plataforma_educacional/features/auth/presentation/pages/welcome_page.dart';
import 'package:plataforma_educacional/main.dart';
import 'package:plataforma_educacional/shared/widgets/uni_background.dart';

void main() {
  test('Palette defines the login gradient and shared cards', () {
    expect(AppColors.background.toARGB32(), 0xFF171719);
    expect(AppColors.gradient.colors, [AppColors.pink, AppColors.blue]);
    expect(AppTheme.dark.scaffoldBackgroundColor, AppColors.background);
    expect(AppTheme.dark.textTheme.headlineMedium?.fontSize, 27);
    expect(AppTheme.dark.textTheme.titleMedium?.fontSize, 12);
  });

  testWidgets('Welcome uses the shared background and app theme', (tester) async {
    await tester.pumpWidget(const UniAiApp());

    expect(find.byType(WelcomePage), findsOneWidget);
    expect(find.byType(UniBackground), findsOneWidget);
    expect(Theme.of(tester.element(find.byType(WelcomePage))).brightness,
        Brightness.dark);
  });
}
