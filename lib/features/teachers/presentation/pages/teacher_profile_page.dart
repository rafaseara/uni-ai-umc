import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/teachers/presentation/widgets/teacher_card.dart';
import 'package:plataforma_educacional/shared/widgets/uni_card.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_layout.dart';
import 'package:plataforma_educacional/shared/widgets/gradient_button.dart';

class TeacherProfilePage extends StatelessWidget {
  const TeacherProfilePage({super.key});

  void _onViewPlansPressed(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.teacherPlans);
  }

  @override
  Widget build(BuildContext context) {
    return UniPageLayout(
      title: 'Perfil do professor',
      subtitle: 'Encontre apoio para seguir aprendendo.',
      children: [
        UniCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const TeacherAvatar(initials: 'AM', size: 48),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Profa. Ana Martins',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Ciência da Computação',
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.blue.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Orientação acadêmica',
                            style: TextStyle(
                              color: AppColors.blue,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Algoritmos, estruturas de dados e lógica de programação.',
                style: TextStyle(color: AppColors.textPrimary, fontSize: 12),
              ),
              const SizedBox(height: 16),
              const _InfoRow(
                icon: Icons.school_outlined,
                label: 'Formação',
                value: 'Doutora em Ciência da Computação',
              ),
              const SizedBox(height: 12),
              const _InfoRow(
                icon: Icons.chat_bubble_outline,
                label: 'Como posso ajudar',
                value: 'Conceitos, exercícios e dúvidas de estudo',
              ),
              const SizedBox(height: 16),
              const _FilledGradientButton(label: 'Chat com professor'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Sobre a orientação',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const UniCard(
          child: Text(
            'Os professores definem seus próprios valores para oferecer '
            'aulas particulares e acompanhamento acadêmico aos alunos.',
            style: TextStyle(color: AppColors.textMuted, fontSize: 11),
          ),
        ),
        const SizedBox(height: 16),
        GradientButton(
          label: 'Ver planos do professor',
          width: double.infinity,
          height: 46,
          onPressed: () => _onViewPlansPressed(context),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.hint),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: AppColors.hint, fontSize: 10),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Botão preenchido com degradê (só esta tela usa).
class _FilledGradientButton extends StatelessWidget {
  const _FilledGradientButton({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 46,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [AppColors.pink, AppColors.blue],
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
