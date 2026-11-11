import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/profile/presentation/pages/profile_page.dart';
import 'package:plataforma_educacional/features/profile/presentation/widgets/profile_background.dart';
import 'package:plataforma_educacional/features/profile/presentation/widgets/profile_colors.dart';
import 'package:plataforma_educacional/features/profile/presentation/widgets/profile_user_card.dart';

class ProfileMenuPage extends StatelessWidget {
  const ProfileMenuPage({super.key});

  void _openProfile(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfilePage()));
  }

  void _notImplemented(BuildContext context, String name) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$name: tela em desenvolvimento')));
  }

  @override
  Widget build(BuildContext context) {
    return ProfileBackground(
      child: Column(
        children: [
          const _ProfileHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  ProfileUserCard(showProfileLink: true, onTap: () => _openProfile(context)),
                  const SizedBox(height: 15),
                  const Text('MEUS ESTUDOS', style: TextStyle(color: ProfileColors.muted, fontSize: 9)),
                  const SizedBox(height: 3),
                  _MenuEntry(icon: Icons.calendar_month_outlined, title: 'Calendário', onTap: () => _notImplemented(context, 'Calendário')),
                  _MenuEntry(icon: Icons.access_time_outlined, title: 'Planejamento semanal', onTap: () => _notImplemented(context, 'Planejamento semanal')),
                  _MenuEntry(icon: Icons.school_outlined, title: 'Professores', onTap: () => _notImplemented(context, 'Professores')),
                  _MenuEntry(icon: Icons.people_outline, title: 'Grupos de estudo', onTap: () => _notImplemented(context, 'Grupos de estudo')),
                  _MenuEntry(icon: Icons.auto_awesome_outlined, title: 'Chat IA', onTap: () => _notImplemented(context, 'Chat IA')),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Divider(color: ProfileColors.border, height: 1)),
                  _MenuEntry(icon: Icons.favorite_border, title: 'Sobrecarga acadêmica', onTap: () => _notImplemented(context, 'Sobrecarga acadêmica')),
                  _MenuEntry(icon: Icons.notifications_none, title: 'Notificações e lembretes', onTap: () => _notImplemented(context, 'Notificações e lembretes')),
                  _MenuEntry(icon: Icons.settings_outlined, title: 'Configurações', onTap: () => _notImplemented(context, 'Configurações')),
                  const SizedBox(height: 12),
                  _OutlineGradientButton(label: 'Sair da conta', onPressed: () => _openProfile(context)),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.white, size: 24),
            onPressed: () { if (Navigator.of(context).canPop()) Navigator.of(context).pop(); },
          ),
          const Expanded(
            child: Center(
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(text: 'Uni', style: TextStyle(color: Colors.white)),
                  TextSpan(text: 'A.I.', style: TextStyle(color: Color(0xFFAC43EB))),
                ]),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFFC1BBCB), size: 21),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _MenuEntry extends StatelessWidget {
  const _MenuEntry({required this.icon, required this.title, required this.onTap});
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
            Icon(icon, size: 19, color: ProfileColors.purple),
            const SizedBox(width: 13),
            Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 12))),
            const Icon(Icons.chevron_right, color: ProfileColors.muted, size: 18),
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
        gradient: const LinearGradient(colors: [ProfileColors.pink, ProfileColors.cyan]),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: ProfileColors.background,
        borderRadius: BorderRadius.circular(9),
        child: InkWell(
          borderRadius: BorderRadius.circular(9),
          onTap: onPressed,
          child: Center(child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600))),
        ),
      ),
    );
  }
}
