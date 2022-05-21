import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wynn_companian_app/widgets/background_container.dart';
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

    await Future.delayed(const Duration(milliseconds: 1500));

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
      body: BackgroundContainer(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: (_height/100)*20),
                child: Image.asset(
                  "assets/images/wynncraft_logo.webp",
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
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
            ),
          ],
        ),
      ),
    );
  }
}
