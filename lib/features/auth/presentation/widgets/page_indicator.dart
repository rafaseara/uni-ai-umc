import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';

/// Pontinhos de progresso das telas de acesso.
/// [activeIndex] começa em 0 (boas-vindas = 0, login = 1, ...).
class PageIndicator extends StatelessWidget {
  const PageIndicator({super.key, required this.activeIndex, this.count = 3});

  final int activeIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          _Dot(active: i == activeIndex),
        ],
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 7,
      height: 7,
      decoration: BoxDecoration(
        color: active ? AuthColors.blue : AuthColors.dotInactive,
        shape: BoxShape.circle,
      ),
    );
  }
}
