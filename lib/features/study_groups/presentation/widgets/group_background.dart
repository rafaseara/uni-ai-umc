import 'package:flutter/material.dart';
import 'package:plataforma_educacional/core/navigation/uni_module_shell.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_background.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';
import 'package:plataforma_educacional/features/home/presentation/widgets/uni_bottom_nav.dart';

import 'group_colors.dart';

class GroupBackground extends StatelessWidget {
  const GroupBackground({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => AuthBackground(child: child);
}

class GroupButton extends StatelessWidget {
  const GroupButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 46,
    child: DecoratedBox(
      decoration: BoxDecoration(
        gradient: GroupColors.gradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.2),
        child: Material(
          color: AuthColors.background,
          borderRadius: BorderRadius.circular(11),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: Colors.white, size: 18),
                  const SizedBox(width: 6),
                ],
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class GroupTopBar extends StatelessWidget {
  const GroupTopBar({super.key, this.showBack = false});
  final bool showBack;
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 54,
    child: Row(
      children: [
        IconButton(
          tooltip: showBack ? 'Voltar' : 'Abrir módulos',
          onPressed: showBack
              ? () => Navigator.maybePop(context)
              : () => Navigator.pushNamed(context, '/modulos'),
          icon: Icon(
            showBack ? Icons.chevron_left : Icons.menu,
            color: Colors.white,
          ),
        ),
        const Spacer(),
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Uni',
                style: TextStyle(color: Colors.white),
              ),
              TextSpan(
                text: 'A.I.',
                style: TextStyle(color: AuthColors.blue),
              ),
            ],
          ),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        const Spacer(),
        IconButton(
          tooltip: 'Notificações',
          onPressed: () => Navigator.pushNamed(context, '/notificacoes'),
          icon: const Icon(Icons.notifications_none, color: Colors.white),
        ),
      ],
    ),
  );
}

class GroupBottomNav extends StatelessWidget {
  const GroupBottomNav({super.key});
  @override
  Widget build(BuildContext context) => HomeBottomNav(
    currentIndex: 1,
    onTap: (index) => UniModuleShell.goToTab(context, index),
  );
}
