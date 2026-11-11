import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:flutter/material.dart';

import '../widgets/logout_background.dart';
import '../widgets/logout_brand.dart';
import '../widgets/logout_colors.dart';

class LogoutSuccessPage extends StatelessWidget {
  const LogoutSuccessPage({super.key});

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
                    SizedBox(height: constraints.maxHeight * 0.16),

                    const LogoutBrand(),

                    const SizedBox(height: 25),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: LogoutColors.card,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: LogoutColors.border),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.check_rounded,
                                color: LogoutColors.cyan,
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Você saiu da sua conta',
                                  style: TextStyle(
                                    color: LogoutColors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Sua sessão foi encerrada nesta '
                            'dispositivo. Seus estudos continuam salvos.',
                            style: TextStyle(
                              color: LogoutColors.muted,
                              fontSize: 11,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    LogoutGradientButton(
                      text: 'Entrar',
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.login,
                          (_) => false,
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Entre novamente para continuar aprendendo.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: LogoutColors.muted, fontSize: 10),
                    ),
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
