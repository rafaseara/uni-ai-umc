import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/teachers/presentation/widgets/plan_card.dart';
import 'package:plataforma_educacional/features/teachers/presentation/widgets/teachers_page_layout.dart';

class TeacherPlansPage extends StatelessWidget {
  const TeacherPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TeachersPageLayout(
      title: 'Planos',
      subtitle: 'O primeiro passo para aprender junto.',
      children: [
        PlanCard(
          title: 'Aula avulsa',
          price: 'R\$ 29,00',
          benefits: ['50 minutos de aula'],
        ),
        SizedBox(height: 12),
        PlanCard(
          title: 'Plano Básico',
          price: 'R\$ 89,90',
          benefits: [
            'Até 4 atendimentos por mês',
            '30 minutos por atendimento',
            'Esclarecimento de dúvidas sobre matérias',
          ],
        ),
        SizedBox(height: 12),
        PlanCard(
          title: 'Plano intermediário',
          price: 'R\$ 99,90',
          benefits: [
            'Até 8 atendimentos por mês',
            '45 minutos por atendimento',
            'Auxílio em exercícios, trabalhos e revisões',
            'Planos de estudos personalizado',
          ],
        ),
      ],
    );
  }
}