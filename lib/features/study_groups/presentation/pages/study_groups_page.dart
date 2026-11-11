import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/study_groups/models/study_group.dart';
import 'package:plataforma_educacional/features/study_groups/presentation/controllers/group_controller.dart';
import 'package:plataforma_educacional/features/study_groups/presentation/pages/create_group_page.dart';
import 'package:plataforma_educacional/features/study_groups/presentation/pages/group_details_page.dart';
import 'package:plataforma_educacional/features/study_groups/presentation/widgets/group_controls.dart';
import 'package:plataforma_educacional/shared/widgets/uni_card.dart';
import 'package:plataforma_educacional/shared/widgets/uni_controlled_list.dart';
import 'package:plataforma_educacional/shared/widgets/uni_empty_state.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_layout.dart';

class StudyGroupsPage extends StatefulWidget {
  const StudyGroupsPage({super.key});

  @override
  State<StudyGroupsPage> createState() => _StudyGroupsPageState();
}

class _StudyGroupsPageState extends State<StudyGroupsPage> {
  final _searchController = TextEditingController();

  String _search = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _createGroup() async {
    final newGroup = await Navigator.push<StudyGroup>(
      context,
      MaterialPageRoute(builder: (_) => const CreateGroupPage()),
    );

    if (!mounted || newGroup == null) return;

    await context.read<GroupController>().add(newGroup);
  }

  void _openGroup(StudyGroup group) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => GroupDetailsPage(group: group)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return UniPageLayout(
      title: 'Grupos de estudo',
      subtitle: 'Compartilhe e aprenda com seus amigos.',
      children: [
        TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() => _search = value);
          },
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: 'Buscar grupo',
            hintStyle: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 12,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.textMuted,
            ),
            filled: true,
            fillColor: AppColors.card,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(color: AppColors.cardBorder),
            ),
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Meus grupos',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 14),
        UniControlledList<StudyGroup>(
          controller: context.watch<GroupController>(),
          emptyState: UniEmptyState(
            icon: Icons.groups_outlined,
            title: 'Você ainda não tem grupos',
            message: 'Crie um grupo para estudar com seus amigos.',
            actionLabel: 'Criar grupo',
            onAction: _createGroup,
          ),
          builder: (context, groups) {
            final query = _search.trim().toLowerCase();
            final filtered = groups.where(
              (group) => group.name.toLowerCase().contains(query),
            ).toList();
            if (filtered.isEmpty) {
              return const UniEmptyState(
                icon: Icons.search_off_outlined,
                title: 'Nenhum grupo encontrado',
                message: 'Tente buscar por outro nome.',
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${filtered.length} grupos',
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
                ),
                const SizedBox(height: 14),
                for (final group in filtered)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 13),
                    child: _groupCard(group),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 8),
        GroupButton(text: '+ Novo Grupo', onPressed: _createGroup)
      ],
    );
  }

  Widget _groupCard(StudyGroup group) {
    return InkWell(
      onTap: () => _openGroup(group),
      borderRadius: BorderRadius.circular(12),
      child: UniCard(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    group.name,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.textMuted),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              group.description,
              style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
            ),
            const SizedBox(height: 15),
            const Divider(color: AppColors.cardBorder),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.description_outlined,
                  color: AppColors.purple,
                  size: 17,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    group.materials.isEmpty
                        ? 'Sem materiais'
                        : group.materials.first,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 11),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.blue,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    group.nextActivity,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Text(
                group.activityDate,
                style: const TextStyle(color: AppColors.textMuted, fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
