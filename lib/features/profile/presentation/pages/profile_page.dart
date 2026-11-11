import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/profile/presentation/widgets/profile_background.dart';
import 'package:plataforma_educacional/features/profile/presentation/widgets/profile_colors.dart';
import 'package:plataforma_educacional/features/profile/presentation/widgets/profile_user_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileBackground(
      child: Column(
        children: [
          SizedBox(
            height: 62,
            child: Row(
              children: [
                IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.chevron_left, color: Colors.white)),
                const Expanded(child: Center(child: Text('UniA.I.', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)))),
                IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: Colors.white)),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const Text('Sua conta', style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 7),
                  const Text('Você está conectado como Gabriel.', style: TextStyle(color: ProfileColors.muted, fontSize: 11)),
                  const SizedBox(height: 15),
                  const ProfileUserCard(),
                  const SizedBox(height: 18),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: ProfileColors.card, borderRadius: BorderRadius.circular(14), border: Border.all(color: ProfileColors.border)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.logout, color: ProfileColors.purple),
                        const SizedBox(height: 14),
                        const Text('Deseja sair da conta?', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 14),
                        const Text('Sua sessão será encerrada neste dispositivo.', style: TextStyle(color: Colors.white, fontSize: 11)),
                        const SizedBox(height: 9),
                        const Text('Seus estudos e materiais continuam salvos na sua conta. Você pode entrar novamente quando quiser.', style: TextStyle(color: ProfileColors.muted, fontSize: 11)),
                        const SizedBox(height: 16),
                        SizedBox(width: double.infinity, height: 40, child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF592D41), foregroundColor: Colors.white),
                          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saída demonstrativa: integração com autenticação pendente.'))),
                          child: const Text('Sair da conta', style: TextStyle(fontSize: 12)),
                        )),
                        const SizedBox(height: 10),
                        SizedBox(width: double.infinity, height: 40, child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Continuar conectado', style: TextStyle(fontSize: 12, color: Colors.white)),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
