

import 'package:wynncraft_companion_app/providers/item_search_provider.dart';
import 'package:wynncraft_companion_app/providers/player_search_provider.dart';

import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'exports.dart';

void main() async {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PageChange()),
          ChangeNotifierProvider(create: (context) => PlayerSearchProvider()),
          ChangeNotifierProvider(create: (context) => ItemSearchProvider()),
        ],
        child: const AppMain()
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: appTertiaryColour,
  ));
}

class AppMain extends StatefulWidget {
  const AppMain({Key? key}) : super(key: key);

  @override
  State<AppMain> createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WynnCraft Companian',
      theme: ThemeData(
        fontFamily: 'Impact',
        iconTheme: const IconThemeData(
          color: appSecondaryColour,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            side: const BorderSide(
              width: 3,
              color: Colors.transparent,
            ),
            backgroundColor: appSecondaryColour,
            shadowColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4)
            ),
          ),
        ),
      ),
      color: appPrimaryColour,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}