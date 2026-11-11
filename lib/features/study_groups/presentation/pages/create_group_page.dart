import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/study_groups/models/study_group.dart';
import 'package:plataforma_educacional/features/study_groups/presentation/controllers/group_controller.dart';
import 'package:plataforma_educacional/features/study_groups/presentation/widgets/group_controls.dart';
import 'package:plataforma_educacional/shared/uni_validators.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_layout.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({super.key});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<String> _members = [];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _showMembers() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, updateSheet) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Adicionar amigos',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...context.watch<GroupController>().suggestedMembers.map((member) {
                      final selected = _members.contains(member);

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.cardBorder,
                          child: Text(
                            member[0],
                            style: const TextStyle(color: AppColors.purple),
                          ),
                        ),
                        title: Text(
                          member,
                          style: const TextStyle(color: AppColors.textPrimary),
                        ),
                        trailing: Icon(
                          selected
                              ? Icons.check_circle
                              : Icons.add_circle_outline,
                          color: AppColors.blue,
                        ),
                        onTap: () {
                          updateSheet(() {
                            setState(() {
                              if (selected) {
                                _members.remove(member);
                              } else {
                                _members.add(member);
                              }
                            });
                          });
                        },
                      );
                    }),
                    const SizedBox(height: 12),
                    GroupButton(
                      text: 'Concluir',
                      onPressed: () => Navigator.pop(sheetContext),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _createGroup() {
    if (!_formKey.currentState!.validate()) return;

    final group = StudyGroup(
      id: 'group-${DateTime.now().microsecondsSinceEpoch}',
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      members: List.of(_members),
      nextActivity: 'Nenhuma atividade cadastrada',
      nextActivityAt: null,
      materials: const [],
    );

    Navigator.pop(context, group);
  }

  @override
  Widget build(BuildContext context) {
    return UniPageLayout(
      title: 'Criar Grupo',
      subtitle: 'Compartilhe seus estudos com seus amigos.',
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nome do grupo',
                style: TextStyle(color: AppColors.textPrimary, fontSize: 12),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: _decoration('Digite o nome do seu grupo'),
                validator: (value) =>
                    value == null || value.trim().isEmpty
                    ? 'Informe o nome do grupo.'
                    : null,
              ),
              const SizedBox(height: 20),
              const Text(
                'Descrição',
                style: TextStyle(color: AppColors.textPrimary, fontSize: 12),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                validator: (value) => UniValidators.nonEmpty(value, 'a descrição do grupo'),
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: _decoration('Digite a descrição do grupo'),
              ),
              const SizedBox(height: 22),
              InkWell(
                onTap: _showMembers,
                child: Container(
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person_add_alt_1_outlined,
                        color: AppColors.blue,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _members.isEmpty
                              ? 'Adicionar mais amigos +'
                              : '${_members.length} amigo(s) selecionado(s)',
                          style: const TextStyle(
                            color: AppColors.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_members.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  children: _members
                      .map(
                        (member) => Chip(
                          label: Text(member),
                          onDeleted: () {
                            setState(() => _members.remove(member));
                          },
                        ),
                      )
                      .toList(),
                ),
              ],
              const SizedBox(height: 24),
              GroupButton(text: 'Criar Grupo', onPressed: _createGroup),
            ],
          ),
        ),
      ],
    );
  }

  InputDecoration _decoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 12),
      filled: true,
      fillColor: AppColors.card,
      contentPadding: const EdgeInsets.all(15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: AppColors.cardBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: AppColors.cardBorder),
      ),
    );
  }
}
