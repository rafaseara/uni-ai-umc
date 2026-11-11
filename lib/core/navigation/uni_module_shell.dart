import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';
import 'package:plataforma_educacional/features/home/presentation/widgets/uni_bottom_nav.dart';

/// Navegação principal comum aos módulos. Preserva as telas já existentes.
class UniModuleShell extends StatelessWidget {
  const UniModuleShell({
    super.key,
    required this.child,
    required this.currentIndex,
  });
  final Widget child;
  final int currentIndex;

  static void goToTab(BuildContext context, int index) {
    const tabs = ['/home', '/grupos', '/chat', '/calendario', '/menu-perfil'];
    final target = tabs[index];
    if (ModalRoute.of(context)?.settings.name == target) return;
    if (index == 0) {
      Navigator.pushNamedAndRemoveUntil(context, target, (_) => false);
    } else {
      Navigator.pushNamed(context, target);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AuthColors.background,
    body: child,
    bottomNavigationBar: SafeArea(
      top: false,
      child: HomeBottomNav(
        currentIndex: currentIndex,
        onTap: (index) => goToTab(context, index),
      ),
    ),
  );
}
