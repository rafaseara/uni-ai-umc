import 'package:flutter/material.dart';

import '../widgets/logout_background.dart';
import '../widgets/logout_brand.dart';
import '../widgets/logout_colors.dart';

class LogoutEntryPage extends StatelessWidget {
  final VoidCallback? onLogin;
  final VoidCallback? onRegister;

  const LogoutEntryPage({super.key, this.onLogin, this.onRegister});

  @override
  Widget build(BuildContext context) {
    return LogoutBackground(
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'A navegação para o login '
                                'será integrada à autenticação.',
                              ),
                            ),
                          );
                        }
                      },
                    ),

                    const SizedBox(height: 16),

                    TextButton(
                      onPressed: () {
                        if (onRegister != null) {
                          onRegister!();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'A navegação para o cadastro '
                                'será integrada à autenticação.',
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Criar uma conta',
                        style: TextStyle(
                          color: LogoutColors.muted,
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
