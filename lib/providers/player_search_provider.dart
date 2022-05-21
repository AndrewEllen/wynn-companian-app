import '../exports.dart';
import 'package:flutter/cupertino.dart';
import '../models/player.dart';

class PlayerSearchProvider with ChangeNotifier {
  String _playerSearchName = "";
  late var _playerSearchNamesList = [];

  String get playerSearchName => _playerSearchName;
  get playerSearchNamesList => _playerSearchNamesList;

  void updatePlayer(String newName) {
    _playerSearchName = newName;
    notifyListeners();
  }

  void updatePlayerSearchList(var newSearchNames) {
    _playerSearchNamesList = newSearchNames;
  }
}