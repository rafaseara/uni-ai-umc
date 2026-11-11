import 'package:plataforma_educacional/core/presentation/list_controller.dart';
import 'package:plataforma_educacional/features/friends/data/friend_repository.dart';
import 'package:plataforma_educacional/features/friends/models/friend_preview.dart';

class FriendController extends ListController<FriendPreview> {
  FriendController(this._friendsRepository) : super(_friendsRepository);
  final FriendRepository _friendsRepository;
  List<FriendPreview> _searchResults = const [];
  List<FriendPreview> get searchResults => List.unmodifiable(_searchResults);
  LoadStatus searchStatus = LoadStatus.initial;
  int _searchId = 0;

  Future<void> search(String query) async {
    if (isDisposed) return;
    final id = ++_searchId;
    searchStatus = LoadStatus.loading;
    notifyListeners();
    try {
      final result = await _friendsRepository.search(query);
      if (id != _searchId || isDisposed) return;
      _searchResults = result;
      searchStatus = LoadStatus.ready;
    } catch (_) {
      if (id != _searchId || isDisposed) return;
      searchStatus = LoadStatus.error;
    }
    notifyListeners();
  }

}
