import 'package:flutter/material.dart';

import 'friends_colors.dart';

class FriendCard extends StatelessWidget {
  final String initials;
  final String name;
  final String course;
  final int friendsCount;
  final VoidCallback? onTap;

  const FriendCard({
    super.key,
    required this.initials,
    required this.name,
    required this.course,
    required this.friendsCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: FriendsColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: FriendsColors.border, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap:
              onTap ??
              () => showDialog<void>(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: Text(name),
                  content: Text(
                    'Estudante de $course.\n\n'
                    'Este perfil utiliza dados demonstrativos.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text('Fechar'),
                    ),
                  ],
                ),
              ),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: FriendsColors.purple.withValues(alpha: 0.06),
                    border: Border.all(color: FriendsColors.purple, width: 1),
                  ),
                  child: Text(
                    initials,
                    style: const TextStyle(
                      color: FriendsColors.purple,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: FriendsColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Estudante · $course',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: FriendsColors.muted,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '$friendsCount ${friendsCount == 1 ? "Amigo" : "Amigos"}',
                        style: const TextStyle(
                          color: FriendsColors.muted,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
