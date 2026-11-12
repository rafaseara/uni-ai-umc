import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/teachers/models/teacher_preview.dart';
import 'package:plataforma_educacional/features/teachers/presentation/controllers/teacher_controller.dart';
import 'package:plataforma_educacional/features/teachers/presentation/widgets/teacher_card.dart';
import 'package:plataforma_educacional/features/teachers/presentation/widgets/teachers_filter_chips.dart';
import 'package:plataforma_educacional/features/teachers/presentation/widgets/teachers_search_field.dart';
import 'package:plataforma_educacional/shared/widgets/uni_controlled_list.dart';
import 'package:plataforma_educacional/shared/widgets/uni_empty_state.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_layout.dart';

class TeachersPage extends StatefulWidget {
  const TeachersPage({super.key});

  @override
  State<TeachersPage> createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  String _query = '';
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    return UniPageLayout(
      title: 'Professores',
      subtitle: 'Encontre apoio para o mais longe.',
      children: [
        TeachersSearchField(
          onChanged: (value) => setState(() => _query = value),
        ),
        const SizedBox(height: 14),
        TeachersFilterChips(
          labels: const ['Todos', 'Tecnologia', 'Exatas'],
          selectedIndex: _selectedFilter,
          onSelected: (index) => setState(() => _selectedFilter = index),
        ),
        const SizedBox(height: 20),
        const Text(
          'Orientação acadêmica',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        UniControlledList<TeacherPreview>(
          controller: context.watch<TeacherController>(),
          emptyState: const UniEmptyState(
            icon: Icons.school_outlined,
            title: 'Nenhum professor encontrado',
            message: 'Ainda não há professores cadastrados.',
          ),
          builder: (context, teachers) {
            final query = _query.trim().toLowerCase();
            final filtered = teachers.where((teacher) {
              final matchesQuery =
                  teacher.name.toLowerCase().contains(query) ||
                  teacher.subject.toLowerCase().contains(query);
              final matchesFilter =
                  _selectedFilter == 0 ||
                  (_selectedFilter == 1 &&
                      teacher.subject.toLowerCase().contains('algoritmos')) ||
                  (_selectedFilter == 2 &&
                      teacher.subject.toLowerCase().contains('matemática'));
              return matchesQuery && matchesFilter;
            }).toList();
            if (filtered.isEmpty) {
              return const UniEmptyState(
                icon: Icons.search_off,
                title: 'Nenhum professor encontrado',
                message: 'Tente buscar por outro nome ou área.',
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${filtered.length} professores',
                  style: const TextStyle(color: AppColors.hint, fontSize: 11),
                ),
                const SizedBox(height: 12),
                for (final teacher in filtered) ...[
                  TeacherCard(
                    initials: teacher.initials,
                    name: teacher.name,
                    subject: teacher.subject,
                    onViewProfile: () =>
                        Navigator.pushNamed(context, AppRoutes.teacherProfile),
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            );
          },
        ),
        const SizedBox(height: 8),
        const Text(
          'Os valores e as regras são definidos por cada professor.',
          style: TextStyle(color: AppColors.hint, fontSize: 10),
        ),
      ],
    );
  }
}
