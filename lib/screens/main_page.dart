import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../exports.dart';


class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<CurvedNavigationBarState> _NavigationBarKey = GlobalKey();
  bool _loading = true;

  final pages = [
    const HomePage(),
  ];

  int _currentNavigatorIndex = 2;
  int _previousIndex = 2;

  static const List<Widget> itemsUnselected = [
    Icon(Icons.fitness_center, size: 30, color: Colors.white,),
    Icon(MdiIcons.foodApple, size: 30, color: Colors.white,),
    Icon(Icons.home, size: 30, color: Colors.white,),
    Icon(MdiIcons.ruler, size: 30, color: Colors.white,),
    Icon(MdiIcons.informationOutline, size: 30, color: Colors.white,),
  ];

  static final List<Widget> itemsSelected = [
    const Icon(Icons.fitness_center, size: 40, color: appSecondaryColour,),
    const Icon(MdiIcons.foodApple, size: 40, color: appSecondaryColour,),
    const Icon(Icons.home, size: 40, color: appSecondaryColour,),
    const Icon(MdiIcons.ruler, size: 40, color: appSecondaryColour,),
    const Icon(MdiIcons.informationOutline, size: 40, color: appSecondaryColour,),
  ];

  late List<Widget> items;

  @override
  void initState() {
    items = [...itemsUnselected];
    items[_currentNavigatorIndex] = itemsSelected[_currentNavigatorIndex];

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _loading = false;
      });
    });

    super.initState();
  }

  navBarColor(int index) {
    setState(() {
      _previousIndex = _currentNavigatorIndex;
      _currentNavigatorIndex = index;
      context.read<PageChange>().changePage(pages[index]);

      items[_currentNavigatorIndex] = itemsSelected[_currentNavigatorIndex];
      items[_previousIndex] = itemsUnselected[_previousIndex];
    });

    //_PageController.jumpToPage(_currentNavigatorIndex);
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
          bottom: false,
          child: Scaffold(
            backgroundColor: appPrimaryColour,
            bottomNavigationBar: CurvedNavigationBar(
                key: _NavigationBarKey,
                backgroundColor: Colors.transparent,
                buttonBackgroundColor: appTertiaryColour,
                color: appTertiaryColour,
                index: _currentNavigatorIndex,
                height: 46,
                animationDuration: const Duration(milliseconds: 150),
                items: items,
                onTap: (index) {
                  navBarColor(index);
                }
            ),
            body: _loading
                ? const Center(
                child: CircularProgressIndicator(
                  color: appSecondaryColour,
                ))
                : context.watch<PageChange>().pageWidget,
            ),
    );
  }
}