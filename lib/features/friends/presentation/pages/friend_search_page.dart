import 'package:flutter/material.dart';

import '../widgets/friends_background.dart';
import '../widgets/friends_colors.dart';
import '../widgets/friend_card.dart';

class FriendSearchPage extends StatefulWidget {
  const FriendSearchPage({super.key});

  @override
  State<FriendSearchPage> createState() => _FriendSearchPageState();
}

class _FriendSearchPageState extends State<FriendSearchPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _students = [
    {
      'initials': 'FL',
      'name': 'Fernando Luiz',
      'course': 'Ciência da Computação',
      'friendsCount': 10,
    },
  ];

  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredStudents = _students.where((student) {
      final name = (student['name'] as String).toLowerCase();
      return name.contains(_query.toLowerCase().trim());
    }).toList();

    return FriendsBackground(
      child: Column(
        children: [
          const FriendsHeader(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: FriendsColors.background.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(color: FriendsColors.cyan, width: 1),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _query = value;
                        });
                      },
                      cursorColor: FriendsColors.cyan,
                      style: const TextStyle(
                        color: FriendsColors.white,
                        fontSize: 13,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Digite o nome do seu amigo',
                        hintStyle: TextStyle(
                          color: FriendsColors.muted,
                          fontSize: 12,
                        ),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: FriendsColors.white,
                          size: 21,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                        isDense: true,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  if (filteredStudents.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: Center(
                        child: Text(
                          'Nenhum amigo encontrado.',
                          style: TextStyle(
                            color: FriendsColors.muted,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    )
                  else
                    ...filteredStudents.map(
                      (student) => FriendCard(
                        initials: student['initials'] as String,
                        name: student['name'] as String,
                        course: student['course'] as String,
                        friendsCount: student['friendsCount'] as int,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
