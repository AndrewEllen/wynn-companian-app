import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:transitioned_indexed_stack/transitioned_indexed_stack.dart';
import '../constants.dart';
import '../exports.dart';
import 'item_search.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _loading = true;

  final pages = [
    const HomePage(),
    const PlayerSearchScreen(),
    const HomePage(),
    const ItemSearchScreen(),
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
    debugPrint(index.toString());
    context.read<PageChange>().navigatorBarNavigationReset(index);
    setState(() {
      _previousIndex = _currentNavigatorIndex;
      _currentNavigatorIndex = index;
      items[_currentNavigatorIndex] = itemsSelected[_currentNavigatorIndex];
      items[_previousIndex] = itemsUnselected[_previousIndex];
    });
  }

  Future<bool> _onBackKey() async {
    if (context.read<PageChange>().pageWidgetCacheIndex == 0 || context.read<PageChange>().navigationBarCache) {
      return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: appTertiaryColour,
          titleTextStyle: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
          contentTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          title: const Text('Are you sure?'),
          content: const Text('Do you want to close the app?'),
          actions: <Widget>[

            ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              "No",
            ),
            ),

            ElevatedButton(
              onPressed: () => SystemNavigator.pop(),
              child: const Text(
                "Yes",
              ),
            ),

          ],
        ),
      )) ??
          false;
    } else {
      context.read<PageChange>().backPage();
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
          bottom: false,
          child: PopScope(
            onPopInvoked: (value) => _onBackKey(),
            canPop: false,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: appPrimaryColour,
              bottomNavigationBar: NavigationBarTheme(
                data: NavigationBarThemeData(
                  labelTextStyle:
                  MaterialStateProperty.resolveWith<TextStyle>(
                        (Set<MaterialState> states) => states
                        .contains(MaterialState.selected)
                        ? const TextStyle(color: appSecondaryColour)
                        : const TextStyle(color: Colors.white),
                  ),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.4),
                        spreadRadius: 3,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: NavigationBar(
                    height: 70,//70.h,
                    elevation: 10,
                    shadowColor: Colors.black,
                    surfaceTintColor: Colors.transparent,
                    indicatorColor: appQuarternaryColour,
                    labelBehavior:
                    NavigationDestinationLabelBehavior.alwaysHide,
                    selectedIndex: _currentNavigatorIndex,
                    onDestinationSelected: (int index) =>
                        navBarColor(index),
                    backgroundColor: appTertiaryColour,
                    destinations: [
                      NavigationDestination(
                        icon: itemsUnselected[0],
                        selectedIcon: itemsSelected[0],
                        label: "Workouts",
                      ),
                      NavigationDestination(
                        icon: itemsUnselected[1],
                        selectedIcon: itemsSelected[1],
                        label: "Diet",
                      ),
                      NavigationDestination(
                        icon: itemsUnselected[2],
                        selectedIcon: itemsSelected[2],
                        label: "Home",
                      ),
                      NavigationDestination(
                        icon: itemsUnselected[3],
                        selectedIcon: itemsSelected[3],
                        label: "Metrics",
                      ),
                      NavigationDestination(
                        icon: itemsUnselected[4],
                        selectedIcon: itemsSelected[4],
                        label: "Metrics",
                      ),
                    ],
                  ),
                ),
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
                  : ScaleIndexedStack(
                duration: Duration(milliseconds: 100),
                beginScale: context.read<PageChange>().transitionScaleFactor,
                endScale: 1,
                index: context.read<PageChange>().pageWidgetCacheIndex,
                children: context.watch<PageChange>().pageWidgetCache,
              ),
              ),
          ),
    );
  }
}