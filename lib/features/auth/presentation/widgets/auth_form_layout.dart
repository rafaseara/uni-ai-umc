import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_background.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_logo.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/gradient_button.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/page_indicator.dart';

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
  });

  final List<Widget> children;
  final int activeIndex;
  final int indicatorCount;
  final VoidCallback onContinue;
  final bool showLogo;

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
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
                    if (showLogo) ...[
                      const SizedBox(height: 40),
                      Center(child: AuthLogo(size: logoSize)),
                      const SizedBox(height: 32),
                    ] else
                      const SizedBox(height: 80),
                    ...children,
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
