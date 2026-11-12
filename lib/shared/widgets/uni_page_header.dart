import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/core/theme/app_text.dart';

/// CabeÃ§alho Ãºnico das pÃ¡ginas internas. Sempre preserva o centro da marca.
class UniPageHeader extends StatelessWidget {
  const UniPageHeader({
    super.key,
    this.showBack = true,
    this.onBack,
    this.onNotifications,
  });

  final bool showBack;
  final VoidCallback? onBack;
  final VoidCallback? onNotifications;

  void _goBack(BuildContext context) {
    if (onBack != null) {
      onBack!();
      return;
    }
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (AppRoutes.isTabRoute(currentRoute) && currentRoute != AppRoutes.home) {
      AppRoutes.goHome(context);
      return;
    }
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
    } else if (currentRoute != AppRoutes.modules) {
      navigator.pushReplacementNamed(AppRoutes.modules);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          SizedBox(
            width: 56,
            child: showBack
                ? IconButton(
                    tooltip: 'Voltar',
                    onPressed: () => _goBack(context),
                    icon: const Icon(
                      Icons.chevron_left,
                      color: AppColors.textPrimary,
                      size: 24,
                    ),
                  )
                : null,
          ),
          Expanded(
            child: Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Uni',
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                    TextSpan(
                      text: 'A.I.',
                      style: TextStyle(color: AppColors.blue),
                    ),
                  ],
                ),
                maxLines: 1,
                style: AppText.title.copyWith(fontSize: 18),
              ),
            ),
          ),
          SizedBox(
            width: 56,
            child: IconButton(
              tooltip: 'NotificaÃ§Ãµes',
              onPressed:
                  ModalRoute.of(context)?.settings.name ==
                      AppRoutes.notifications
                  ? null
                  : () {
                      if (onNotifications != null) {
                        onNotifications!();
                      } else {
                        Navigator.pushNamed(context, AppRoutes.notifications);
                      }
                    },
              icon: const Icon(
                Icons.notifications_none,
                color: AppColors.textPrimary,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
