import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/theme/app_colors.dart';

class UniBottomNav extends StatelessWidget {
  const UniBottomNav({
    super.key,
    this.currentIndex,
    required this.onTap,
  }) : assert(currentIndex == null || (currentIndex >= 0 && currentIndex < 5));

  final int? currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    const items = [
      _NavItem(
        label: 'Início',
        icon: Icons.home_outlined,
        selectedIcon: Icons.home_rounded,
      ),
      _NavItem(
        label: 'Grupos',
        icon: Icons.people_outline,
        selectedIcon: Icons.people,
      ),
      _NavItem(
        label: 'Chat IA',
        icon: Icons.auto_awesome_outlined,
        selectedIcon: Icons.auto_awesome,
      ),
      _NavItem(
        label: 'Agenda',
        icon: Icons.calendar_month_outlined,
        selectedIcon: Icons.calendar_month,
      ),
      _NavItem(
        label: 'Perfil',
        icon: Icons.account_circle_outlined,
        selectedIcon: Icons.account_circle,
      ),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
      decoration: const BoxDecoration(
        color: AppColors.navBackground,
        border: Border(top: BorderSide(color: AppColors.cardBorder, width: 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final selected = currentIndex == index;
          final isChat = index == 2;

          final itemColor = selected
              ? AppColors.blue
              : AppColors.textMuted;

          return Expanded(
            child: Semantics(
              button: true,
              selected: selected,
              label: item.label,
              child: Material(
                color: AppColors.transparent,
                child: InkWell(
                  onTap: () => onTap(index),
                  borderRadius: BorderRadius.circular(14),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 4,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 38,
                          child: Center(
                            child: isChat
                                ? _AiChatButton(selected: selected)
                                : Icon(
                                    selected ? item.selectedIcon : item.icon,
                                    color: itemColor,
                                    size: 23,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            item.label,
                            style: TextStyle(
                              color: isChat ? AppColors.textPrimary : itemColor,
                              fontSize: 10,
                              fontWeight: selected
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _AiChatButton extends StatelessWidget {
  const _AiChatButton({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.pink, AppColors.logoRingMiddle, AppColors.blue],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple
                .withValues(alpha: selected ? 0.45 : 0.25),
            blurRadius: selected ? 12 : 7,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.logoRingMiddle.withValues(alpha: 0.70),
          borderRadius: BorderRadius.circular(11),
        ),
        child: const Icon(Icons.auto_awesome, color: AppColors.textPrimary, size: 21),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}
