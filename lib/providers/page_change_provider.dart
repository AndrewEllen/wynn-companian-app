import '../exports.dart';
import 'package:flutter/cupertino.dart';

class PageChange with ChangeNotifier {
  Widget _pageWidget = const HomePage();

  Widget get pageWidget => _pageWidget;

  void changePage(Widget newPage) {
    _pageWidget = newPage;
    notifyListeners();
  }
}