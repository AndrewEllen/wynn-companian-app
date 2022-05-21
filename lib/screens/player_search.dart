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
  late var PlayerSearchData = [];

  SearchPlayerDatabase() async {

    late List PlayersNames;
    PlayersNames = await SearchPlayers(
        context.read<PlayerSearchProvider>().playerSearchName);

    for (int i = 0; i < PlayersNames.length; i++) {
      var UUID = await SearchUUID(PlayersNames[i]);
      PlayerSearchData.add([PlayersNames[i], UUID]);
    }
    return PlayerSearchData;
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
          child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 22),
                      child: SearchBar(),
                    ),
                    FutureBuilder(
                      future: SearchPlayerDatabase(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          if (context.read<PlayerSearchProvider>().playerSearchName.isNotEmpty) {
                            return Center(
                              child: Container(
                                margin: const EdgeInsets.only(top:30),
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
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        } else {
                          return Container(
                            margin: const EdgeInsets.only(top:5),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height/1.22,
                            child: ListView.builder(
                              itemCount: PlayerSearchData.length,
                              itemBuilder: (BuildContext context, int index) {
                                return PlayerSearchContainer(
                                    playerData: PlayerSearchData[index]);
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
