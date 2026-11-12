import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/core/theme/app_theme.dart';
import 'package:plataforma_educacional/shared/widgets/uni_background.dart';
import 'package:plataforma_educacional/shared/widgets/uni_card.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_header.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_layout.dart';

void main() {
  testWidgets('Layout único preserva título, fundo, rodapé e cards', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: const UniPageLayout(
          title: 'Professores',
          subtitle: 'Encontre apoio para seguir aprendendo.',
          bottom: Text('Rodapé persistente'),
          children: [UniCard(child: Text('Conteúdo fictício'))],
        ),
        routes: {
          AppRoutes.modules: (_) => const Scaffold(body: Text('Módulos')),
          AppRoutes.notifications: (_) =>
              const Scaffold(body: Text('Notificações')),
        },
      ),
    );

    expect(find.byType(UniBackground), findsOneWidget);
    expect(find.byType(UniPageHeader), findsOneWidget);
    expect(find.text('Professores'), findsOneWidget);
    expect(find.text('Conteúdo fictício'), findsOneWidget);
    expect(find.text('Rodapé persistente'), findsOneWidget);
    expect(find.byType(UniCard), findsOneWidget);

    await tester.tap(
      find.ancestor(
        of: find.byIcon(Icons.notifications_none),
        matching: find.byType(IconButton),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Notificações'), findsOneWidget);
  });

  testWidgets('Voltar sem histórico abre módulos', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: const UniPageLayout(title: 'Amigos', subtitle: '', children: []),
        routes: {
          AppRoutes.modules: (_) => const Scaffold(body: Text('Módulos')),
          AppRoutes.notifications: (_) =>
              const Scaffold(body: Text('Notificações')),
        },
      ),
    );
    await tester.tap(find.byTooltip('Voltar'));
    await tester.pumpAndSettle();
    expect(find.text('Módulos'), findsOneWidget);
  });

  testWidgets('Card usa cor e borda definidas no tema', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: UniCard(child: Text('Teste'))),
      ),
    );
    final cardContainer = tester.widget<Container>(
      find
          .descendant(
            of: find.byType(UniCard),
            matching: find.byType(Container),
          )
          .first,
    );
    final decoration = cardContainer.decoration! as BoxDecoration;
    expect(decoration.color, AppColors.card);
    expect(decoration.borderRadius, BorderRadius.circular(12));
    expect((decoration.border! as Border).top.color, AppColors.cardBorder);
  });
}
