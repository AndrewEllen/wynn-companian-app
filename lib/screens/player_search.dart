import 'package:flutter/material.dart';
import 'package:wynn_companian_app/providers/player_search_provider.dart';
import '../helpers/api_get.dart';
import '../models/player.dart';
import '../widgets/background_container.dart';
import '../exports.dart';
import '../constants.dart';
import 'package:provider/provider.dart';
import '../widgets/player_search_container.dart';
import '../widgets/searchbar.dart';

class PlayerSearchScreen extends StatefulWidget {
  const PlayerSearchScreen({Key? key}) : super(key: key);

  @override
  State<PlayerSearchScreen> createState() => _PlayerSearchScreenState();
}

class _PlayerSearchScreenState extends State<PlayerSearchScreen> {
  late var PlayerSearchData;
  bool _loading = true;

  SearchPlayerDatabase() async {
    PlayerSearchData = [];
    late List PlayersNames;
    PlayersNames = await SearchPlayers(context.read<PlayerSearchProvider>().playerSearchName);

    for (int i = 0; i < PlayersNames.length; i++) {
      var UUID = await SearchUUID(PlayersNames[i]);
      PlayerSearchData.add([PlayersNames[i], UUID]);
    }

    print(PlayerSearchData);
    return PlayerSearchData;
  }

  @override
  void initState() {
    _loading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<PlayerSearchProvider>().playerSearchName;
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
                      margin: EdgeInsets.only(top: 22),
                      child: SearchBar(),
                    ),
                    FutureBuilder(
                      future: SearchPlayerDatabase(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: LinearProgressIndicator(
                                color: appGoldStatic2,
                                backgroundColor: appGoldStatic1,
                              ),
                            );
                          } else {
                            return SizedBox(
                              width: double.infinity,
                              height: 500,
                              child: ListView.builder(
                                itemCount: PlayerSearchData.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return PlayerSearchContainer(playerData: PlayerSearchData[index]);
                                  },
                              ),
                            );
                          }
                        },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
