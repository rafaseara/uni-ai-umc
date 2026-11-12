import 'package:plataforma_educacional/core/data/in_memory_store.dart';
import 'package:plataforma_educacional/features/friends/data/friend_repository.dart';
import 'package:plataforma_educacional/features/friends/models/friend_preview.dart';

class InMemoryFriendRepository extends InMemoryStore<FriendPreview>
    implements FriendRepository {
  InMemoryFriendRepository({super.delay})
    : super([
        const FriendPreview(
          id: 'friend-1',
          initials: 'GF',
          name: 'Gabriel Fernandes',
          course: 'Direito',
          friendsCount: 10,
        ),
        const FriendPreview(
          id: 'friend-2',
          initials: 'JM',
          name: 'Junior Miguel',
          course: 'Ciência da Computação',
          friendsCount: 5,
        ),
        const FriendPreview(
          id: 'friend-3',
          initials: 'BS',
          name: 'Beatriz Santos',
          course: 'Medicina',
          friendsCount: 67,
        ),
        const FriendPreview(
          id: 'friend-4',
          initials: 'AF',
          name: 'Arthur Ferreira',
          course: 'Arquitetura',
          friendsCount: 54,
        ),
        const FriendPreview(
          id: 'friend-5',
          initials: 'MJ',
          name: 'Maria Julia',
          course: 'Ciência da Computação',
          friendsCount: 10,
        ),
      ]);
  final List<FriendPreview> _suggestions = const [
    FriendPreview(
      id: 'friend-search-1',
      initials: 'FL',
      name: 'Fernando Luiz',
      course: 'Ciência da Computação',
      friendsCount: 10,
    ),
  ];

  @override
  Future<List<FriendPreview>> search(String query) async {
    await Future<void>.delayed(delay);
    final normalized = query.trim().toLowerCase();
    return List.unmodifiable(
      _suggestions.where(
        (friend) => friend.name.toLowerCase().contains(normalized),
      ),
    );
  }
}
