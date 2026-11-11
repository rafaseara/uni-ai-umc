import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';
import 'package:plataforma_educacional/features/teachers/presentation/widgets/teacher_card.dart';
import 'package:plataforma_educacional/features/teachers/presentation/widgets/teachers_empty_state.dart';
import 'package:plataforma_educacional/features/teachers/presentation/widgets/teachers_filter_chips.dart';
import 'package:plataforma_educacional/features/teachers/presentation/widgets/teachers_page_layout.dart';
import 'package:plataforma_educacional/features/teachers/presentation/widgets/teachers_search_field.dart';

class TeachersPage extends StatelessWidget {
  const TeachersPage({super.key});

  // Dados fictícios só para montar o visual.
  // Deixe a lista vazia para ver o estado "nenhum professor encontrado".
  static const _teachers = [
    (initials: 'AM', name: 'Ana Martins', subject: 'Algoritmos e programação'),
    (initials: 'RC', name: 'Rafael Costa', subject: 'Matemática e cálculo'),
  ];

  void _onViewProfilePressed() {
    // TODO: navegar para o perfil do professor
  }

  @override
  Widget build(BuildContext context) {
    return TeachersPageLayout(
      title: 'Professores',
      subtitle: 'Encontre apoio para o mais longe.',
      children: [
        const TeachersSearchField(),
        const SizedBox(height: 14),
        const TeachersFilterChips(labels: ['Todos', 'Tecnologia', 'Exatas']),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Orientação acadêmica',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${_teachers.length} professores',
              style: const TextStyle(color: AuthColors.hint, fontSize: 11),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (_teachers.isEmpty)
          const TeachersEmptyState()
        else
          for (final teacher in _teachers) ...[
            TeacherCard(
              initials: teacher.initials,
              name: teacher.name,
              subject: teacher.subject,
              onViewProfile: _onViewProfilePressed,
            ),
            const SizedBox(height: 12),
          ],
        const SizedBox(height: 8),
        const Text(
          'Os valores e as regras são definidos por cada professor.',
          style: TextStyle(color: AuthColors.hint, fontSize: 10),
        ),
      ],
    );
  }
}
