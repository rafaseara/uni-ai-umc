import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:plataforma_educacional/core/di/app_providers.dart';
import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/navigation/uni_module_shell.dart';
import 'package:plataforma_educacional/shared/widgets/uni_bottom_nav.dart';

class _NavigationHistory extends NavigatorObserver {
  final List<Route<dynamic>> _stack = [];

  List<String?> get routeNames =>
      _stack.map((route) => route.settings.name).toList();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _stack.add(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _stack.remove(route);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _stack.remove(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (oldRoute == null || newRoute == null) return;
    final oldIndex = _stack.indexOf(oldRoute);
    if (oldIndex >= 0) {
      _stack[oldIndex] = newRoute;
    }
  }
}

void main() {
  setUpAll(() async { await initializeDateFormatting('pt_BR'); });
  test('Abas são centralizadas e na ordem do menu inferior', () {
    expect(AppRoutes.tabRoutes, [
      AppRoutes.home,
      AppRoutes.groups,
      AppRoutes.chat,
      AppRoutes.calendar,
      AppRoutes.profileMenu,
    ]);
    expect(AppRoutes.routeForTab(3), AppRoutes.calendar);
    expect(AppRoutes.isTabRoute(AppRoutes.groups), isTrue);
    expect(AppRoutes.isTabRoute(AppRoutes.planner), isFalse);
  });

  testWidgets('Trocar de aba não acumula histórico e voltar chega à Home',
      (tester) async {
    final navigatorKey = GlobalKey<NavigatorState>();
    final history = _NavigationHistory();
    await tester.pumpWidget(AppProviders(child: MaterialApp(
      navigatorKey: navigatorKey,
      initialRoute: AppRoutes.welcome,
      routes: AppRoutes.routes,
      navigatorObservers: [history],
    )));
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil(AppRoutes.home, (_) => false);
    await tester.pumpAndSettle();
    expect(history.routeNames, [AppRoutes.home]);

    Future<void> selectTab(String label, String target) async {
      final tab = find.descendant(
        of: find.byType(UniBottomNav),
        matching: find.text(label),
      );
      await tester.tap(tab);
      await tester.pumpAndSettle();
      expect(history.routeNames, [AppRoutes.home, target]);
      expect(find.byType(UniBottomNav), findsOneWidget);
      expect(find.byType(UniModuleShell), findsOneWidget);
    }

    await selectTab('Grupos', AppRoutes.groups);
    await selectTab('Chat IA', AppRoutes.chat);
    await selectTab('Agenda', AppRoutes.calendar);
    await selectTab('Perfil', AppRoutes.profileMenu);

    // Cabeçalho de aba retorna à Home, mesmo após várias trocas.
    await tester.tap(find.byTooltip('Voltar'));
    await tester.pumpAndSettle();
    expect(history.routeNames, [AppRoutes.home]);
    expect(find.byType(UniBottomNav), findsOneWidget);
  });

  testWidgets('Entrar em aba a partir de Módulos descarta o menu',
      (tester) async {
    final navigatorKey = GlobalKey<NavigatorState>();
    final history = _NavigationHistory();
    await tester.pumpWidget(AppProviders(child: MaterialApp(
      navigatorKey: navigatorKey,
      initialRoute: AppRoutes.welcome,
      routes: AppRoutes.routes,
      navigatorObservers: [history],
    )));
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil(AppRoutes.home, (_) => false);
    await tester.pumpAndSettle();
    navigatorKey.currentState!.pushNamed(AppRoutes.modules);
    await tester.pumpAndSettle();
    expect(history.routeNames, [AppRoutes.home, AppRoutes.modules]);

    await tester.tap(find.text('Grupos de estudo'));
    await tester.pumpAndSettle();
    expect(history.routeNames, [AppRoutes.home, AppRoutes.groups]);

    // Simula o botão físico voltar, que deve chegar à Home.
    navigatorKey.currentState!.pop();
    await tester.pumpAndSettle();
    expect(history.routeNames, [AppRoutes.home]);
  });

  testWidgets('Submódulos ficam sem seleção e detalhes ficam sem barra',
      (tester) async {
    final navigatorKey = GlobalKey<NavigatorState>();
    await tester.pumpWidget(AppProviders(child: MaterialApp(
      navigatorKey: navigatorKey,
      initialRoute: AppRoutes.welcome,
      routes: AppRoutes.routes,
    )));
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil(AppRoutes.home, (_) => false);
    await tester.pumpAndSettle();
    navigatorKey.currentState!.pushNamed(AppRoutes.planner);
    await tester.pumpAndSettle();
    expect(tester.widget<UniBottomNav>(find.byType(UniBottomNav)).currentIndex,
        isNull);

    AppRoutes.goToTab(tester.element(find.byType(UniBottomNav)), 2);
    await tester.pumpAndSettle();
    expect(tester.widget<UniBottomNav>(find.byType(UniBottomNav)).currentIndex,
        2);
    navigatorKey.currentState!.pushNamed(AppRoutes.chatConversation);
    await tester.pumpAndSettle();
    expect(find.byType(UniBottomNav), findsNothing);
    await tester.tap(find.byTooltip('Voltar'));
    await tester.pumpAndSettle();
    expect(find.byType(UniBottomNav), findsOneWidget);
  });
}
