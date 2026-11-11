import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/core/presentation/list_controller.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/friends/presentation/controllers/friend_controller.dart';
import 'package:plataforma_educacional/features/friends/presentation/widgets/friend_card.dart';
import 'package:plataforma_educacional/shared/widgets/uni_empty_state.dart';
import 'package:plataforma_educacional/shared/widgets/uni_error_state.dart';
import 'package:plataforma_educacional/shared/widgets/uni_loading.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_layout.dart';

class FriendSearchPage extends StatefulWidget {
  const FriendSearchPage({super.key});

  @override
  State<FriendSearchPage> createState() => _FriendSearchPageState();
}

class _FriendSearchPageState extends State<FriendSearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // A pesquisa pertence ao controller e é mantida ao navegar.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<FriendController>().search('');
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UniPageLayout(
      title: '',
      subtitle: '',
      showTitle: false,
      children: [
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.background.withValues(alpha: 0.65),
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: AppColors.blue, width: 1),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              context.read<FriendController>().search(value);
            },
            cursorColor: AppColors.blue,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
            ),
            decoration: const InputDecoration(
              hintText: 'Digite o nome do seu amigo',
              hintStyle: TextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: AppColors.textPrimary,
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
        Builder(builder: (context) {
          final controller = context.watch<FriendController>();
          if (controller.searchStatus == LoadStatus.initial ||
              controller.searchStatus == LoadStatus.loading) {
            return const UniLoading();
          }
          if (controller.searchStatus == LoadStatus.error) {
            return UniErrorState(onRetry: () => controller.search(_searchController.text));
          }
          final filtered = controller.searchResults;
          if (filtered.isEmpty) {
            return const UniEmptyState(
              icon: Icons.search_off,
              title: 'Nenhum amigo encontrado',
              message: 'Tente outro nome na busca.',
            );
          }
          return Column(children: [
            for (final student in filtered)
              FriendCard(initials: student.initials, name: student.name,
                course: student.course, friendsCount: student.friendsCount),
          ]);
        }),
      ],
    );
  }
}
