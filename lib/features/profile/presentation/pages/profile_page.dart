import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/auth/presentation/controllers/auth_controller.dart';
import 'package:plataforma_educacional/features/profile/presentation/widgets/profile_user_card.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_layout.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return UniPageLayout(
      title: 'Sua conta',
      subtitle: 'Perfil demonstrativo do estudante.',
      children: [
        const ProfileUserCard(),
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.logout, color: AppColors.purple),
              const SizedBox(height: 14),
              const Text(
                'Deseja sair da conta?',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Sua sessão será encerrada neste dispositivo.',
                style: TextStyle(color: AppColors.textPrimary, fontSize: 11),
              ),
              const SizedBox(height: 9),
              const Text(
                'Seus estudos e materiais continuam salvos na sua conta. Você pode entrar novamente quando quiser.',
                style: TextStyle(color: AppColors.textMuted, fontSize: 11),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.card,
                    foregroundColor: AppColors.textPrimary,
                  ),
                  onPressed: () {
                    context.read<AuthController>().signOut();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.logoutSuccess,
                      (_) => false,
                    );
                  },
                  child: const Text(
                    'Sair da conta',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: OutlinedButton(
                  onPressed: () {
                    final navigator = Navigator.of(context);
                    if (navigator.canPop()) {
                      navigator.pop();
                    } else {
                      AppRoutes.goHome(context);
                    }
                  },
                  child: const Text(
                    'Continuar conectado',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
