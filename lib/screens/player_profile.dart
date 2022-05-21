import 'package:flutter/material.dart';
import 'package:wynn_companian_app/helpers/api_get.dart';
import 'package:wynn_companian_app/widgets/background_container.dart';

import '../constants.dart';

class PlayerProfile extends StatefulWidget {
  PlayerProfile({Key? key, required this.playerData}) : super(key: key);
  late List playerData;

  @override
  State<PlayerProfile> createState() => _PlayerProfileState();
}

class _PlayerProfileState extends State<PlayerProfile> {
  late final List playerData;
  late var playerStatsData;
  bool _loading = true;

  chooseNameColour(String rank) {
    List<String> ranks = [
      "null",
      "VIP",
      "VIP+",
      "HERO",
      "CHAMPION"
    ];

    List<Color> colours = [
      Color.fromRGBO(255, 255, 255, 1.0),
      Color.fromRGBO(49, 226, 49, 1.0),
      Color.fromRGBO(73, 239, 239, 1.0),
      Color.fromRGBO(153, 11, 153, 1.0),
      Color.fromRGBO(253, 253, 41, 1.0),
    ];

    return colours[ranks.indexOf(rank)];
  }

  fetchStatsData() async {
    playerStatsData = await SearchUserStats(widget.playerData[1]);
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    playerData = widget.playerData;
    playerStatsData = fetchStatsData();
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
            child: Center(
              child: _loading
                  ? Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 30),
                        width: MediaQuery.of(context).size.width / 1.25,
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
                  : Profile(),
            ),
          ),
        ));
  }

  Widget Profile() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 40,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(
          color: appTertiaryColour,
          width: 2,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: appQuinaryColour,
            width: 2,
          ),
          color: appQuarternaryColour,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.only(left:8,top:8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(3)),
                  border: Border.all(
                    color: appTertiaryColour,
                    width: 2,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: appQuinaryColour,
                      width: 2,
                    ),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        appQuinaryColour,
                        appQuarternaryColour,
                        appQuinaryColour,
                      ],
                    ),
                  ),
                  width: 120,
                  height: 180,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: FadeInImage(
                          placeholder: AssetImage("assets/images/stevemodel.png"),
                          image: NetworkImage('https://crafatar.com/renders/body/${playerData[1]}?overlay=true'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: const EdgeInsets.only(right:8,top:8),
                width: 230,
                height: 184,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(3)),
                  border: Border.all(
                    color: appTertiaryColour,
                    width: 2,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: appQuinaryColour,
                      width: 2,
                    ),
                    color: appQuarternaryColour,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 8, top: 8),
                          child: Text(
                            playerStatsData[0]["username"],
                            style: TextStyle(
                              color: chooseNameColour(playerStatsData[0]["meta"]["tag"]["value"]),
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
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

/*child: FutureBuilder(
              future: fetchStatsData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  if (playerStatsData.isEmpty) {
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
                  );
                }
              },
            ),*/
