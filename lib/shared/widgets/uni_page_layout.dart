import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/shared/widgets/uni_background.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_header.dart';

/// Composição única: fundo, cabeçalho, título, conteúdo rolável e rodapé.
/// O [bottom] permanece visível quando o teclado abre ou a lista rola.
class UniPageLayout extends StatelessWidget {
  const UniPageLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
    this.showBack = true,
    this.showTitle = true,
    this.bottom,
    this.floatingAction,
    this.titleAction,
    this.bottomPadding = const EdgeInsets.fromLTRB(20, 8, 20, 16),
  });

  final String title;
  final String subtitle;
  final List<Widget> children;
  final bool showBack;
  /// Útil nas páginas que originalmente não tinham título (busca, menu de perfil).
  final bool showTitle;
  final Widget? titleAction;
  final Widget? bottom;
  final Widget? floatingAction;
  final EdgeInsetsGeometry bottomPadding;

  @override
  Widget build(BuildContext context) {
    return UniBackground(
      child: Stack(
        children: [
          Column(
            children: [
              UniPageHeader(showBack: showBack),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showTitle) ...[
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (titleAction != null) titleAction!,
                          ],
                        ),
                        if (subtitle.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                        const SizedBox(height: 20),
                      ],
                      ...children,
                    ],
                  ),
                ),
              ),
              if (bottom != null)
                Padding(padding: bottomPadding, child: bottom!),
            ],
          ),
          if (floatingAction != null)
            Positioned(
              right: 20,
              bottom: bottom == null ? 16 : 80,
              child: floatingAction!,
            ),
        ],
      ),
    );
  }
}
