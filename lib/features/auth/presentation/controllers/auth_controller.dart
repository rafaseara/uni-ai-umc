import 'package:flutter/foundation.dart';

/// Identidade local de demonstração; nenhuma credencial é validada ou salva.
class AuthController extends ChangeNotifier {
  String _studentName = 'Gabriel Muniz';
  bool _signedIn = false;

  String get studentName => _studentName;
  String get initials => _studentName.trim().isEmpty
      ? 'E'
      : _studentName.trim().split(RegExp(r'\s+')).take(2).map((word) => word[0].toUpperCase()).join();
  bool get signedIn => _signedIn;

  void signIn({String? name}) {
    if (name != null && name.trim().isNotEmpty) _studentName = name.trim();
    _signedIn = true;
    notifyListeners();
  }

  void signOut() {
    _signedIn = false;
    notifyListeners();
  }
}
