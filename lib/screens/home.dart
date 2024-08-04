import 'package:flutter/material.dart';
import '../widgets/background_container.dart';
import '../constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = true;

  @override
  void initState() {
    _loading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appPrimaryColour,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: BackgroundContainer(
          child: _loading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: appGoldStatic1,
                ))
              : ListView(
                children: const [

                ],
              ),
        ),
      ),
    );
  }
}
