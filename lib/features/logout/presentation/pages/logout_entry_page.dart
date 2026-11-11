import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/logout/presentation/widgets/logout_brand.dart';
import 'package:plataforma_educacional/shared/widgets/uni_background.dart';

class LogoutEntryPage extends StatelessWidget {
  final VoidCallback? onLogin;
  final VoidCallback? onRegister;

  const LogoutEntryPage({super.key, this.onLogin, this.onRegister});

  @override
  Widget build(BuildContext context) {
    return UniBackground(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.17),

                    const LogoutBrand(),

                    SizedBox(height: constraints.maxHeight * 0.30),

                    LogoutGradientButton(
                      text: 'Entrar',
                      onPressed: () {
                        if (onLogin != null) {
                          onLogin!();
                        } else {
                          Navigator.pushReplacementNamed(context, AppRoutes.login);
                        }
                      },
                    ),

                    const SizedBox(height: 16),

                    TextButton(
                      onPressed: () {
                        if (onRegister != null) {
                          onRegister!();
                        } else {
                          Navigator.pushReplacementNamed(context, AppRoutes.signUp);
                        }
                      },
                      child: const Text(
                        'Criar uma conta',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 11,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
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
