import 'package:flutter/material.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  }) : assert(currentIndex >= 0 && currentIndex < 5);

  final int currentIndex;
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
        color: Color(0xF2171719),
        border: Border(
          top: BorderSide(
            color: Color(0xFF353139),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final selected = currentIndex == index;
          final isChat = index == 2;

          final itemColor = selected
              ? const Color(0xFF00BFFF)
              : const Color(0xFFCCCCCC);

          return Expanded(
            child: Semantics(
              button: true,
              selected: selected,
              label: item.label,
              child: Material(
                color: Colors.transparent,
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
                                ? _AiChatButton(
                                    selected: selected,
                                  )
                                : Icon(
                                    selected
                                        ? item.selectedIcon
                                        : item.icon,
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
                              color: isChat
                                  ? Colors.white
                                  : itemColor,
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
  const _AiChatButton({
    required this.selected,
  });

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
          colors: [
            Color(0xFFE500C5),
            Color(0xFF64118F),
            Color(0xFF00BFFF),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9415B5).withValues(
              alpha: selected ? 0.45 : 0.25,
            ),
            blurRadius: selected ? 12 : 7,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF64118F).withValues(alpha: 0.70),
          borderRadius: BorderRadius.circular(11),
        ),
        child: const Icon(
          Icons.auto_awesome,
          color: Colors.white,
          size: 21,
        ),
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