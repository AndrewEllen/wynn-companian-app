import 'package:flutter/cupertino.dart';

class ItemSearchProvider with ChangeNotifier {
  String _itemSearchName = "";

  String get itemSearchName => _itemSearchName;

  void updateItem(String newItem) {
    _itemSearchName = newItem;
    notifyListeners();
  }

}