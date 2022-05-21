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

  chooseNameColour(String rank, String adminRank) {
    if (adminRank != "Player") {
      rank = adminRank;
    }

    List<String> ranks = [
      "null",
      "VIP",
      "VIP+",
      "HERO",
      "CHAMPION",
      "Administrator",
      "Moderator",
      "Media",
      "Hybrid",
      "Builder",
      "GM",
      "CMD",
    ];

    List<Color> colours = const [
      Color.fromRGBO(255, 255, 255, 1.0),
      Color.fromRGBO(49, 226, 49, 1.0),
      Color.fromRGBO(73, 239, 239, 1.0),
      Color.fromRGBO(153, 11, 153, 1.0),
      Color.fromRGBO(253, 253, 41, 1.0),
      Color.fromRGBO(175, 0, 0, 1.0),
      Color.fromRGBO(227, 97, 11, 1.0),
      Color.fromRGBO(239, 45, 255, 1.0),
      Color.fromRGBO(51, 148, 177, 1.0),
      Color.fromRGBO(20, 79, 168, 1.0),
      Color.fromRGBO(241, 44, 109, 1.0),
      Color.fromRGBO(177, 80, 51, 1.0),
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
                margin: const EdgeInsets.only(left: 8, top: 8),
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
                          placeholder:
                              AssetImage("assets/images/stevemodel.png"),
                          image: NetworkImage(
                              'https://crafatar.com/renders/body/${playerData[1]}?overlay=true'),
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
                margin: const EdgeInsets.only(right: 8, top: 8),
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
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10, top: 8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: playerStatsData[0]["meta"]["location"]
                                            ["online"] ==
                                        false
                                    ? const Color.fromRGBO(114, 114, 114, 1.0)
                                    : Colors.green,
                              ),
                              width: 22,
                              height: 22,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 8, top: 8),
                              child: Text(
                                "${playerStatsData[0]["username"]}",
                                style: TextStyle(
                                  shadows: const [
                                    Shadow(
                                      offset: Offset(0.0, 1.0),
                                      blurRadius: 5.0,
                                      color: Color.fromRGBO(1, 1, 1, 1),
                                    ),
                                  ],
                                  color: chooseNameColour(
                                    playerStatsData[0]["meta"]["tag"]["value"],
                                    playerStatsData[0]["rank"],
                                  ),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, top: 1),
                            child: playerStatsData[0]["meta"]["location"]["server"] == null ? const Text(
                              "Offline",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ) : Text(
                              "Online on ${playerStatsData[0]["meta"]["location"]["server"]}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 472,
                margin: const EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                  left: 8,
                  right: 8,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
