import 'package:flutter/material.dart';

import 'group_colors.dart';

class GroupBackground extends StatelessWidget {
  final Widget child;

  const GroupBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GroupColors.background,
      body: SafeArea(child: child),
    );
  }
}

class GroupButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const GroupButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: GroupColors.gradient,
          borderRadius: BorderRadius.circular(9),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, color: Colors.white, size: 17),
                const SizedBox(width: 6),
              ],
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GroupTopBar extends StatelessWidget {
  final bool showBack;

  const GroupTopBar({super.key, this.showBack = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: showBack ? () => Navigator.pop(context) : () {},
          icon: Icon(
            showBack ? Icons.chevron_left : Icons.menu,
            color: GroupColors.white,
          ),
        ),
        const Spacer(),
        const Text(
          'Uni',
          style: TextStyle(
            color: GroupColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const Text(
          'A.I.',
          style: TextStyle(
            color: GroupColors.purple,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none, color: GroupColors.white),
        ),
      ],
    );
  }
}

class GroupBottomNav extends StatelessWidget {
  const GroupBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      (Icons.home_outlined, 'Início'),
      (Icons.people_outline, 'Grupos'),
      (Icons.add, 'Criar'),
      (Icons.calendar_month_outlined, 'Agenda'),
      (Icons.person_outline, 'Perfil'),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: const BoxDecoration(
        color: GroupColors.background,
        border: Border(top: BorderSide(color: GroupColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (var i = 0; i < items.length; i++)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: i == 1
                        ? GroupColors.cyan.withValues(alpha: 0.12)
                        : i == 2
                        ? GroupColors.purple.withValues(alpha: 0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    items[i].$1,
                    size: 19,
                    color: i == 1
                        ? GroupColors.cyan
                        : i == 2
                        ? GroupColors.purple
                        : GroupColors.muted,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  items[i].$2,
                  style: const TextStyle(color: GroupColors.muted, fontSize: 9),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
