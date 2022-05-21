import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../exports.dart';
import '../widgets/background_container.dart';


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
    const PlayerSearchScreen(),
    const HomePage(),
    const HomePage(),
    const HomePage(),
  ];

  int _currentNavigatorIndex = 2;
  int _previousIndex = 2;

  static const List<Widget> itemsUnselected = [
    Icon(Icons.flag, size: 30, color: Colors.white,),
    Icon(Icons.person_search, size: 30, color: Colors.white,),
    Icon(Icons.person, size: 30, color: Colors.white,),
    Icon(MdiIcons.treasureChest, size: 30, color: Colors.white,),
    Icon(Icons.leaderboard, size: 30, color: Colors.white,),
  ];

  static final List<Widget> itemsSelected = [
    const Icon(Icons.flag, size: 40, color: appGoldStatic1,),
    const Icon(Icons.person_search, size: 40, color: appGoldStatic1,),
    const Icon(Icons.person, size: 40, color: appGoldStatic1,),
    const Icon(MdiIcons.treasureChest, size: 40, color: appGoldStatic1,),
    const Icon(Icons.leaderboard, size: 40, color: appGoldStatic1,),
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
            resizeToAvoidBottomInset: false,
            backgroundColor: appPrimaryColour,
            bottomNavigationBar: CurvedNavigationBar(
                key: _NavigationBarKey,
                backgroundColor: appPrimaryColour,
                buttonBackgroundColor: appQuarternaryColour,
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
                ? Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width/1.25,
                height: 10,
                child: const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  child: LinearProgressIndicator(
                    color: appGoldStatic2,
                    backgroundColor: appGoldStatic1,
                  ),
                ),
              ),
            )
                : context.watch<PageChange>().pageWidget,
            ),
    );
  }
}