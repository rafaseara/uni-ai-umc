import 'package:flutter/material.dart';

import '../widgets/friends_background.dart';
import '../widgets/friends_colors.dart';
import '../widgets/friend_card.dart';
import 'friend_search_page.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Amigos',
                          style: TextStyle(
                            color: FriendsColors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Buscar amigos',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const FriendSearchPage(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.person_search_outlined,
                          color: FriendsColors.purple,
                          size: 23,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  const FriendCard(
                    initials: 'GF',
                    name: 'Gabriel Fernandes',
                    course: 'Direito',
                    friendsCount: 10,
                  ),

                  const FriendCard(
                    initials: 'JM',
                    name: 'Junior Miguel',
                    course: 'Ciência da Computação',
                    friendsCount: 5,
                  ),

                  const FriendCard(
                    initials: 'BS',
                    name: 'Beatriz Santos',
                    course: 'Medicina',
                    friendsCount: 67,
                  ),

                  const FriendCard(
                    initials: 'AF',
                    name: 'Arthur Ferreira',
                    course: 'Arquitetura',
                    friendsCount: 54,
                  ),

                  const FriendCard(
                    initials: 'MJ',
                    name: 'Maria Julia',
                    course: 'Ciência da Computação',
                    friendsCount: 10,
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
