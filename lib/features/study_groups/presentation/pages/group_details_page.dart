import 'package:flutter/material.dart';

import '../../models/study_group.dart';
import '../widgets/group_background.dart';
import '../widgets/group_colors.dart';

class GroupDetailsPage extends StatefulWidget {
  final StudyGroup group;

  const GroupDetailsPage({super.key, required this.group});

  @override
  State<GroupDetailsPage> createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {
  late StudyGroup group;

  @override
  void initState() {
    super.initState();
    group = widget.group;
  }

  void _showAddMaterial() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: GroupColors.card,
        title: const Text(
          'Novo documento',
          style: TextStyle(color: GroupColors.white),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: GroupColors.white),
          decoration: const InputDecoration(
            hintText: 'Nome do documento',
            hintStyle: TextStyle(color: GroupColors.muted),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isEmpty) return;

              setState(() {
                group = group.copyWith(materials: [...group.materials, name]);
              });

              Navigator.pop(dialogContext);
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  void _showAddActivity() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: GroupColors.card,
        title: const Text(
          'Nova atividade',
          style: TextStyle(color: GroupColors.white),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: GroupColors.white),
          decoration: const InputDecoration(
            hintText: 'Nome da atividade',
            hintStyle: TextStyle(color: GroupColors.muted),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final title = controller.text.trim();
              if (title.isEmpty) return;

              setState(() {
                group = group.copyWith(
                  nextActivity: title,
                  activityDate: 'Data não definida',
                );
              });

              Navigator.pop(dialogContext);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GroupBackground(
      child: Column(
        children: [
          const GroupTopBar(showBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 16, 22, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.name,
                    style: const TextStyle(
                      color: GroupColors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    group.description,
                    style: const TextStyle(
                      color: GroupColors.muted,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 22),
                  _panel(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Participantes',
                              style: TextStyle(
                                color: GroupColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              '${group.members.length} membros',
                              style: const TextStyle(
                                color: GroupColors.muted,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 13),
                        Row(
                          children: [
                            ...group.members
                                .take(5)
                                .map(
                                  (member) => Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: GroupColors.border,
                                      child: Text(
                                        member[0],
                                        style: const TextStyle(
                                          color: GroupColors.purple,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            if (group.members.isEmpty)
                              const Text(
                                'Nenhum participante adicionado',
                                style: TextStyle(
                                  color: GroupColors.muted,
                                  fontSize: 11,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _panel(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Próxima atividade',
                          style: TextStyle(
                            color: GroupColors.cyan,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 9),
                        Text(
                          group.nextActivity,
                          style: const TextStyle(
                            color: GroupColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (group.activityDate.isNotEmpty) ...[
                          const SizedBox(height: 7),
                          Text(
                            group.activityDate,
                            style: const TextStyle(
                              color: GroupColors.muted,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  GroupButton(
                    text: '+ Nova atividade',
                    onPressed: _showAddActivity,
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Materiais compartilhados',
                    style: TextStyle(
                      color: GroupColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (group.materials.isEmpty)
                    _panel(
                      child: const Text(
                        'Nenhum material compartilhado ainda.',
                        style: TextStyle(
                          color: GroupColors.muted,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ...group.materials.map(
                    (material) => Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: _panel(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.description_outlined,
                              color: GroupColors.purple,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                material,
                                style: const TextStyle(
                                  color: GroupColors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const Text(
                              'Leitura',
                              style: TextStyle(
                                color: GroupColors.muted,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  GroupButton(
                    text: '+ Novo Documento',
                    onPressed: _showAddMaterial,
                  ),
                ],
              ),
            ),
          ),
          const GroupBottomNav(),
        ],
      ),
    );
  }

  Widget _panel({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: GroupColors.card,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: GroupColors.border),
      ),
      child: child,
    );
  }
}
