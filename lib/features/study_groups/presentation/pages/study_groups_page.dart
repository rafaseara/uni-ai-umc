import 'package:flutter/material.dart';

import '../../models/study_group.dart';
import '../widgets/group_background.dart';
import '../widgets/group_colors.dart';
import 'create_group_page.dart';
import 'group_details_page.dart';

class StudyGroupsPage extends StatefulWidget {
  const StudyGroupsPage({super.key});

  @override
  State<StudyGroupsPage> createState() => _StudyGroupsPageState();
}

class _StudyGroupsPageState extends State<StudyGroupsPage> {
  final _searchController = TextEditingController();

  final List<StudyGroup> _groups = [
    const StudyGroup(
      name: 'Algoritmos em equipe',
      description: 'Compartilhando conhecimento e projetos',
      members: ['João Miguel', 'Beatriz Santos', 'Gabriel Fernandes'],
      nextActivity: 'Revisão de estruturas de repetição',
      activityDate: '27 de outubro · 19h',
      materials: ['Resumo de Algoritmos'],
    ),
    const StudyGroup(
      name: 'Cálculo sem limites',
      description: 'Estudando cálculo em conjunto',
      members: ['João Miguel', 'Beatriz Santos', 'Arthur Ferreira'],
      nextActivity: 'Entrega da lista de exercícios',
      activityDate: '28 de outubro · 20h',
      materials: ['Lista de exercícios 04'],
    ),
  ];

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

    setState(() => _groups.add(newGroup));
  }

  void _openGroup(StudyGroup group) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => GroupDetailsPage(group: group)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _groups.where((group) {
      return group.name.toLowerCase().contains(_search.toLowerCase());
    }).toList();

    return GroupBackground(
      child: Column(
        children: [
          const GroupTopBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 16, 22, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Grupos de estudo',
                    style: TextStyle(
                      color: GroupColors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Compartilhe e aprenda com seus amigos.',
                    style: TextStyle(color: GroupColors.muted, fontSize: 12),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() => _search = value);
                    },
                    style: const TextStyle(color: GroupColors.white),
                    decoration: InputDecoration(
                      hintText: 'Buscar grupo',
                      hintStyle: const TextStyle(
                        color: GroupColors.muted,
                        fontSize: 12,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: GroupColors.muted,
                      ),
                      filled: true,
                      fillColor: GroupColors.card,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide: const BorderSide(color: GroupColors.border),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      const Text(
                        'Meus grupos',
                        style: TextStyle(
                          color: GroupColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${filtered.length} grupos',
                        style: const TextStyle(
                          color: GroupColors.muted,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  if (filtered.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Center(
                        child: Text(
                          'Nenhum grupo encontrado.',
                          style: TextStyle(color: GroupColors.muted),
                        ),
                      ),
                    ),
                  ...filtered.map(
                    (group) => Padding(
                      padding: const EdgeInsets.only(bottom: 13),
                      child: _groupCard(group),
                    ),
                  ),
                  const SizedBox(height: 8),
                  GroupButton(text: '+ Novo Grupo', onPressed: _createGroup),
                ],
              ),
            ),
          ),
          const GroupBottomNav(),
        ],
      ),
    );
  }

  Widget _groupCard(StudyGroup group) {
    return InkWell(
      onTap: () => _openGroup(group),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: GroupColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: GroupColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    group.name,
                    style: const TextStyle(
                      color: GroupColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right, color: GroupColors.muted),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              group.description,
              style: const TextStyle(color: GroupColors.muted, fontSize: 11),
            ),
            const SizedBox(height: 15),
            const Divider(color: GroupColors.border),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.description_outlined,
                  color: GroupColors.purple,
                  size: 17,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    group.materials.isEmpty
                        ? 'Sem materiais'
                        : group.materials.first,
                    style: const TextStyle(
                      color: GroupColors.white,
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
                  color: GroupColors.cyan,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    group.nextActivity,
                    style: const TextStyle(
                      color: GroupColors.white,
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
                style: const TextStyle(color: GroupColors.muted, fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
