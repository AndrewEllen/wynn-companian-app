import 'package:flutter/material.dart';
import 'package:wynncraft_companion_app/models/playerModel.dart';

import '../helpers/api_get.dart';
import '../providers/player_search_provider.dart';
import '../widgets/background_container.dart';
import '../constants.dart';
import 'package:provider/provider.dart';
import '../widgets/player_search_container.dart';
import '../widgets/player_searchbar.dart';

class PlayerSearchScreen extends StatefulWidget {
  const PlayerSearchScreen({super.key});

  @override
  State<PlayerSearchScreen> createState() => _PlayerSearchScreenState();
}

class _PlayerSearchScreenState extends State<PlayerSearchScreen> {

  SearchPlayerDatabase() async {
    List<PlayerSearchModel> playerSearchData = [];
    late Map playersNames;
    playersNames = await SearchPlayers(context.read<PlayerSearchProvider>().playerSearchName);
    debugPrint("Received");

    playersNames.forEach((key, value) {

      playerSearchData.add(
        PlayerSearchModel(
            userName: value,
            uuid: key,
        )
      );

    });

    return playerSearchData;
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
                      margin: const EdgeInsets.only(top: 22),
                      child: const PlayerSearchBar(),
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
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return PlayerSearchContainer(
                                    playerSearchData: snapshot.data![index]
                                );
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
