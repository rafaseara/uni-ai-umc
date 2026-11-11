import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/friends/models/friend_preview.dart';
import 'package:plataforma_educacional/features/friends/presentation/controllers/friend_controller.dart';
import 'package:plataforma_educacional/features/friends/presentation/widgets/friend_card.dart';
import 'package:plataforma_educacional/shared/widgets/uni_controlled_list.dart';
import 'package:plataforma_educacional/shared/widgets/uni_empty_state.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_layout.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return UniPageLayout(
      title: 'Amigos',
      subtitle: '',
      titleAction: IconButton(
        tooltip: 'Buscar amigos',
        onPressed: () => Navigator.pushNamed(context, AppRoutes.friendSearch),
        icon: const Icon(
          Icons.person_search_outlined,
          color: AppColors.purple,
          size: 23,
        ),
      ),
      children: [
        UniControlledList<FriendPreview>(
          controller: context.watch<FriendController>(),
          emptyState: const UniEmptyState(
            icon: Icons.people_outline,
            title: 'Nenhum amigo adicionado',
            message: 'Busque amigos para começar a se conectar.',
          ),
          builder: (context, friends) => Column(
            children: [
              for (final friend in friends)
                FriendCard(
                  initials: friend.initials,
                  name: friend.name,
                  course: friend.course,
                  friendsCount: friend.friendsCount,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
