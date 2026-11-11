import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/shared/widgets/uni_bottom_nav.dart';

/// Uma única barra inferior para todas as páginas raiz dos módulos.
class UniModuleShell extends StatelessWidget {
  const UniModuleShell({
    super.key,
    required this.child,
    this.currentIndex,
  }) : assert(currentIndex == null || (currentIndex >= 0 && currentIndex < 5));

  final Widget child;

  /// null significa nenhuma aba selecionada (submódulos do menu).
  final int? currentIndex;

  /// Interface de compatibilidade: a tabela de abas pertence a AppRoutes.
  static void goToTab(BuildContext context, int index) =>
      AppRoutes.goToTab(context, index);

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    body: child,
    bottomNavigationBar: SafeArea(
      top: false,
      child: UniBottomNav(
        currentIndex: currentIndex,
        onTap: (index) => goToTab(context, index),
      ),
    ),
  );
}
