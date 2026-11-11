import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_logo.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/page_indicator.dart';
import 'package:plataforma_educacional/shared/widgets/gradient_button.dart';
import 'package:plataforma_educacional/shared/widgets/uni_background.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  void _onLoginPressed(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.login);
  }

  void _onSignUpPressed(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUp);
  }

  @override
  Widget build(BuildContext context) {
    return UniBackground(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final logoSize = math.min(
            constraints.maxWidth * 0.82,
            constraints.maxHeight * 0.42,
          );

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 48),
                AuthLogo(size: logoSize),
                const Spacer(),
                GradientButton(
                  label: 'ENTRAR',
                  onPressed: () => _onLoginPressed(context),
                ),
                const SizedBox(height: 32),
                const PageIndicator(activeIndex: 0),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Não possui uma conta? ',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 13,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _onSignUpPressed(context),
                      child: const Text(
                        'Criar uma conta',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 13,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 75),
              ],
            ),
          );
        },
      ),
    );
  }
}
