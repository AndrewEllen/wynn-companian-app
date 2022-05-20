import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/page_change_provider.dart';
import '../constants.dart';

import 'main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool _loading = true;
  late List<String> categories;

  void fetchData() async {

    await Future.delayed(const Duration(milliseconds: 250));

    setState(() {
      _loading = false;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainPage(),
        ),
      );
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: appPrimaryColour,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: (_height/100)*20),
              child: const Text(
                "Wynn",
                style: TextStyle(
                  color: appSecondaryColour,
                  fontSize: 60,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              color: appSecondaryColour,
            ),
          ),
        ],
      ),
    );
  }
}
