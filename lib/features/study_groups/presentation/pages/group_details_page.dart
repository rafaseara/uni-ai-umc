import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/study_groups/models/study_group.dart';
import 'package:plataforma_educacional/features/study_groups/presentation/controllers/group_controller.dart';
import 'package:plataforma_educacional/features/study_groups/presentation/widgets/group_controls.dart';
import 'package:plataforma_educacional/features/study_groups/presentation/widgets/group_details_sections.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_layout.dart';

class GroupDetailsPage extends StatelessWidget {
  const GroupDetailsPage({super.key, required this.group});
  final StudyGroup group;

  Future<void> _edit(BuildContext context, {required bool material}) async {
    String enteredText = '';
    final text = await showDialog<String>(context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.card,
        title: Text(material ? 'Novo documento' : 'Nova atividade',
          style: const TextStyle(color: AppColors.textPrimary)),
        content: TextField(
          onChanged: (value) => enteredText = value,
          autofocus: true,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: InputDecoration(hintText: material ? 'Nome do documento' : 'Nome da atividade',
            hintStyle: const TextStyle(color: AppColors.textMuted)),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar')),
          TextButton(onPressed: () {
            final value = enteredText.trim();
            if (value.isNotEmpty) Navigator.pop(dialogContext, value);
          }, child: Text(material ? 'Adicionar' : 'Salvar')),
        ],
      ),
    );
    if (text == null || !context.mounted) return;
    final controller = context.read<GroupController>();
    final current = controller.items.where((item) => item.id == group.id).firstOrNull ?? group;
    final updated = material
      ? current.copyWith(materials: [...current.materials, text])
      : current.copyWith(nextActivity: text, resetActivityDate: true);
    await controller.update(updated);
  }

  @override
  Widget build(BuildContext context) {
    final items = context.watch<GroupController>().items;
    final updated = items.where((item) => item.id == group.id).firstOrNull ?? group;
    return UniPageLayout(
      title: updated.name, subtitle: updated.description,
      children: [
        GroupMembersSection(group: updated),
        const SizedBox(height: 16),
        GroupNextActivitySection(group: updated),
        const SizedBox(height: 14),
        GroupButton(text: '+ Nova atividade',
          onPressed: () => _edit(context, material: false)),
        const SizedBox(height: 25),
        GroupMaterialsSection(materials: updated.materials),
        const SizedBox(height: 8),
        GroupButton(text: '+ Novo Documento',
          onPressed: () => _edit(context, material: true)),
      ],
    );
  }
}
