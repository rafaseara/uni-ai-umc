import 'package:flutter/material.dart';

import '../../models/study_group.dart';
import '../widgets/group_background.dart';
import '../widgets/group_colors.dart';

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
  final List<String> _suggestedMembers = [
    'João Miguel',
    'Beatriz Santos',
    'Gabriel Fernandes',
    'Arthur Ferreira',
    'Maria Júlia',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _showMembers() {
    showModalBottomSheet(
      context: context,
      backgroundColor: GroupColors.card,
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
                        color: GroupColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ..._suggestedMembers.map((member) {
                      final selected = _members.contains(member);

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: GroupColors.border,
                          child: Text(
                            member[0],
                            style: const TextStyle(color: GroupColors.purple),
                          ),
                        ),
                        title: Text(
                          member,
                          style: const TextStyle(color: GroupColors.white),
                        ),
                        trailing: Icon(
                          selected
                              ? Icons.check_circle
                              : Icons.add_circle_outline,
                          color: GroupColors.cyan,
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
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      members: List.of(_members),
      nextActivity: 'Nenhuma atividade cadastrada',
      activityDate: '',
      materials: const [],
    );

    Navigator.pop(context, group);
  }

  @override
  Widget build(BuildContext context) {
    return GroupBackground(
      child: Column(
        children: [
          const GroupTopBar(showBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Criar Grupo',
                      style: TextStyle(
                        color: GroupColors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Compartilhe seus estudos com seus amigos.',
                      style: TextStyle(color: GroupColors.muted, fontSize: 12),
                    ),
                    const SizedBox(height: 26),
                    const Text(
                      'Nome do grupo',
                      style: TextStyle(color: GroupColors.white, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: GroupColors.white),
                      decoration: _decoration('Digite o nome do seu grupo'),
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? 'Informe o nome do grupo'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Descrição',
                      style: TextStyle(color: GroupColors.white, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 3,
                      style: const TextStyle(color: GroupColors.white),
                      decoration: _decoration('Digite a descrição do grupo'),
                    ),
                    const SizedBox(height: 22),
                    InkWell(
                      onTap: _showMembers,
                      child: Container(
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          border: Border.all(color: GroupColors.cyan),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person_add_alt_1_outlined,
                              color: GroupColors.cyan,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _members.isEmpty
                                    ? 'Adicionar mais amigos +'
                                    : '${_members.length} amigo(s) selecionado(s)',
                                style: const TextStyle(
                                  color: GroupColors.cyan,
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
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _decoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: GroupColors.muted, fontSize: 12),
      filled: true,
      fillColor: GroupColors.card,
      contentPadding: const EdgeInsets.all(15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: GroupColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: GroupColors.border),
      ),
    );
  }
}
