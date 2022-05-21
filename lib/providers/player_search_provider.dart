import 'package:flutter/cupertino.dart';

class PlayerSearchProvider with ChangeNotifier {
  String _playerSearchName = "";

  String get playerSearchName => _playerSearchName;

  void updatePlayer(String newName) {
    _playerSearchName = newName;
    notifyListeners();
  }
}