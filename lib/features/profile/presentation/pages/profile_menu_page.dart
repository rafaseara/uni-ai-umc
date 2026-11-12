import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/auth/presentation/controllers/auth_controller.dart';
import 'package:plataforma_educacional/features/profile/presentation/widgets/profile_user_card.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_layout.dart';

class ProfileMenuPage extends StatelessWidget {
  const ProfileMenuPage({super.key});

  void _openProfile(BuildContext context) {
    AppRoutes.openModule(context, AppRoutes.profile);
  }

  @override
  Widget build(BuildContext context) {
    return UniPageLayout(
      title: '',
      subtitle: '',
      showTitle: false,
      children: [
        const SizedBox(height: 10),
        ProfileUserCard(
          showProfileLink: true,
          onTap: () => _openProfile(context),
        ),
        const SizedBox(height: 15),
        const Text(
          'MEUS ESTUDOS',
          style: TextStyle(color: AppColors.textMuted, fontSize: 9),
        ),
        const SizedBox(height: 3),
        _MenuEntry(
          icon: Icons.calendar_month_outlined,
          title: 'Calendário',
          onTap: () => AppRoutes.openModule(context, AppRoutes.calendar),
        ),
        _MenuEntry(
          icon: Icons.access_time_outlined,
          title: 'Planejamento semanal',
          onTap: () => AppRoutes.openModule(context, AppRoutes.planner),
        ),
        _MenuEntry(
          icon: Icons.school_outlined,
          title: 'Professores',
          onTap: () => AppRoutes.openModule(context, AppRoutes.teachers),
        ),
        _MenuEntry(
          icon: Icons.people_outline,
          title: 'Grupos de estudo',
          onTap: () => AppRoutes.openModule(context, AppRoutes.groups),
        ),
        _MenuEntry(
          icon: Icons.auto_awesome_outlined,
          title: 'Chat IA',
          onTap: () => AppRoutes.openModule(context, AppRoutes.chat),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Divider(color: AppColors.cardBorder, height: 1),
        ),
        _MenuEntry(
          icon: Icons.favorite_border,
          title: 'Sobrecarga acadêmica',
          onTap: () => AppRoutes.openModule(context, AppRoutes.workload),
        ),
        _MenuEntry(
          icon: Icons.notifications_none,
          title: 'Notificações e lembretes',
          onTap: () => AppRoutes.openModule(context, AppRoutes.notifications),
        ),
        _MenuEntry(
          icon: Icons.settings_outlined,
          title: 'Configurações',
          onTap: () => AppRoutes.openModule(context, AppRoutes.settings),
        ),
        const SizedBox(height: 12),
        _OutlineGradientButton(
          label: 'Sair da conta',
          onPressed: () async {
            await context.read<AuthController>().signOut();
            if (!context.mounted) return;
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.logoutSuccess,
              (_) => false,
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _MenuEntry extends StatelessWidget {
  const _MenuEntry({
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, size: 19, color: AppColors.purple),
            const SizedBox(width: 13),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 12,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textMuted,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class _OutlineGradientButton extends StatelessWidget {
  const _OutlineGradientButton({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 43,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.pink, AppColors.blue],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(9),
        child: InkWell(
          borderRadius: BorderRadius.circular(9),
          onTap: onPressed,
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
