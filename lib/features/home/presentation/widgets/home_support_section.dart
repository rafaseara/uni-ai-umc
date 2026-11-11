import 'package:flutter/material.dart';
import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/shared/widgets/gradient_button.dart';
import 'package:plataforma_educacional/shared/widgets/uni_card.dart';

class HomeSupportSection extends StatelessWidget {
  const HomeSupportSection({super.key});

  @override
  Widget build(BuildContext context) => UniCard(
    padding: const EdgeInsets.all(20),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Aprender fica melhor com apoio.', style: TextStyle(
        color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
      const SizedBox(height: 10),
      const Text('Encontre orientação e acompanhe os materiais da sua turma.',
        style: TextStyle(color: AppColors.textMuted, fontSize: 12, height: 1.4)),
      const SizedBox(height: 18),
      LayoutBuilder(builder: (context, constraints) {
        final teachersButton = GradientButton(width: double.infinity,
          label: 'Professores', onPressed: () => Navigator.pushNamed(context, AppRoutes.teachers));
        final groupsButton = GradientButton(width: double.infinity,
          label: 'Meus grupos', onPressed: () => AppRoutes.openModule(context, AppRoutes.groups));
        if (constraints.maxWidth < 280 || MediaQuery.textScalerOf(context).scale(14) > 18) {
          return Column(children: [teachersButton, const SizedBox(height: 12), groupsButton]);
        }
        return Row(children: [Expanded(child: teachersButton), const SizedBox(width: 12),
          Expanded(child: groupsButton)]);
      }),
    ]),
  );
}
