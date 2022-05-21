import '../exports.dart';
import 'package:flutter/cupertino.dart';
import '../models/player.dart';

class PlayerSearchProvider with ChangeNotifier {
  String _playerSearchName = "";

  String get playerSearchName => _playerSearchName;

  void updatePlayer(String newName) {
    _playerSearchName = newName;
    notifyListeners();
  }
}