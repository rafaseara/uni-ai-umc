import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_background.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';

/// Estrutura comum das telas de planejamento:
/// cabeçalho, título, subtítulo e conteúdo rolável.
class PlannerPageLayout extends StatelessWidget {
  const PlannerPageLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                  color: Colors.white,
                  onPressed: () => Navigator.maybePop(context),
                ),
                const Text.rich(
                  TextSpan(
                    text: 'Uni',
                    children: [
                      TextSpan(
                        text: 'A.I.',
                        style: TextStyle(color: AuthColors.blue),
                      ),
                    ],
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_none, size: 22),
                  color: Colors.white,
                  onPressed: () {
                    // TODO: abrir notificações
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: AuthColors.textMuted,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }
}