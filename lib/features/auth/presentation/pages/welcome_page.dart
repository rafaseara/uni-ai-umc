import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_background.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_logo.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/gradient_button.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/page_indicator.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  void _onLoginPressed() {
    // TODO: Navegar para login
  }

  void _onSignUpPressed() {
    // TODO: Navegar para cadastro
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
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
                GradientButton(label: 'ENTRAR', onPressed: _onLoginPressed),
                const SizedBox(height: 32),
                const PageIndicator(activeIndex: 0),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Não possui uma conta? ',
                      style: TextStyle(
                        color: AuthColors.textMuted,
                        fontSize: 13,
                      ),
                    ),
                    GestureDetector(
                      onTap: _onSignUpPressed,
                      child: const Text(
                        'Criar uma conta',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
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
