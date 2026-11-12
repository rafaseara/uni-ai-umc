import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_logo.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/page_indicator.dart';
import 'package:plataforma_educacional/shared/widgets/gradient_button.dart';
import 'package:plataforma_educacional/shared/widgets/uni_background.dart';

/// Estrutura comum das telas de formulário: logo opcional, campos,
/// botão CONTINUAR embaixo e indicador de passos.
class AuthFormLayout extends StatelessWidget {
  const AuthFormLayout({
    super.key,
    required this.children,
    required this.activeIndex,
    required this.indicatorCount,
    required this.onContinue,
    this.showLogo = false,
    this.formKey,
  });

  final List<Widget> children;
  final int activeIndex;
  final int indicatorCount;
  final VoidCallback onContinue;
  final bool showLogo;
  final GlobalKey<FormState>? formKey;

  @override
  Widget build(BuildContext context) {
    return UniBackground(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final logoSize = math.min(constraints.maxWidth * 0.40, 170.0);

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        tooltip: 'Voltar',
                        icon: const Icon(
                          Icons.chevron_left,
                          color: AppColors.textPrimary,
                        ),
                        onPressed: () {
                          final navigator = Navigator.of(context);
                          if (navigator.canPop()) {
                            navigator.pop();
                          } else {
                            navigator.pushReplacementNamed(AppRoutes.welcome);
                          }
                        },
                      ),
                    ),
                    if (showLogo) ...[
                      const SizedBox(height: 8),
                      Center(child: AuthLogo(size: logoSize)),
                      const SizedBox(height: 32),
                    ] else
                      const SizedBox(height: 32),
                    if (formKey == null)
                      ...children
                    else
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: children,
                        ),
                      ),
                    const Spacer(),
                    Center(
                      child: GradientButton(
                        label: 'CONTINUAR',
                        onPressed: onContinue,
                      ),
                    ),
                    const SizedBox(height: 32),
                    PageIndicator(
                      activeIndex: activeIndex,
                      count: indicatorCount,
                    ),
                    const SizedBox(height: 75),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
