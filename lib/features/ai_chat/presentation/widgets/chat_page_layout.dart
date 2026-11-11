import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_background.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';

/// Estrutura comum das telas do Chat IA.
class ChatPageLayout extends StatelessWidget {
  const ChatPageLayout({
    super.key,
    required this.subtitle,
    required this.children,
    required this.bottom,
    this.showBackButton = false,
  });

  final String subtitle;
  final List<Widget> children;
  final Widget bottom;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    showBackButton ? Icons.arrow_back_ios_new : Icons.menu,
                    size: showBackButton ? 18 : 22,
                  ),
                  color: Colors.white,
                  onPressed: () {
                    if (showBackButton) {
                      Navigator.maybePop(context);
                    } else {
                      Navigator.pushNamed(context, '/modulos');
                    }
                  },
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
                    Navigator.pushNamed(context, '/notificacoes');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Chat IA',
                    style: TextStyle(
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
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: bottom,
          ),
        ],
      ),
    );
  }
}
