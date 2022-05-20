import 'package:flutter/material.dart';
import '../widgets/background_container.dart';
import '../exports.dart';
import '../constants.dart';
import 'package:provider/provider.dart';

import '../widgets/searchbar.dart';

class PlayerSearchScreen extends StatefulWidget {
  const PlayerSearchScreen({Key? key}) : super(key: key);

  @override
  State<PlayerSearchScreen> createState() => _PlayerSearchScreenState();
}

class _PlayerSearchScreenState extends State<PlayerSearchScreen> {
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
                color: appSecondaryColour,
              ))
              : ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top:22),
                child: SearchBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
