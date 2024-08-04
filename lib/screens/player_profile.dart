import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wynncraft_companion_app/models/playerModel.dart';

import '../constants.dart';
import '../helpers/api_get.dart';
import '../widgets/background_container.dart';

class PlayerProfile extends StatefulWidget {
  PlayerProfile({super.key, required this.playerData});
  late PlayerSearchModel playerData;

  @override
  State<PlayerProfile> createState() => _PlayerProfileState();
}

class _PlayerProfileState extends State<PlayerProfile> {

  chooseNameColour(String rank, String adminRank) {

    rank = rank.toLowerCase();
    adminRank = adminRank.toLowerCase();

    if (adminRank != "player") {
      rank = adminRank;
    }

    List<String> ranks = [
      "",
      "null",
      "vip",
      "vip+",
      "hero",
      "champion",
      "administrator",
      "moderator",
      "media",
      "hybrid",
      "item",
      "builder",
      "gm",
      "cmd",
    ];

    List<Color> colours = const [
      Color.fromRGBO(255, 255, 255, 1.0),
      Color.fromRGBO(255, 255, 255, 1.0),
      Color.fromRGBO(49, 226, 49, 1.0),
      Color.fromRGBO(73, 239, 239, 1.0),
      Color.fromRGBO(153, 11, 153, 1.0),
      Color.fromRGBO(253, 253, 41, 1.0),
      Color.fromRGBO(175, 0, 0, 1.0),
      Color.fromRGBO(227, 97, 11, 1.0),
      Color.fromRGBO(239, 45, 255, 1.0),
      Color.fromRGBO(51, 148, 177, 1.0),
      Color.fromRGBO(79, 199, 229, 1.0),
      Color.fromRGBO(20, 79, 168, 1.0),
      Color.fromRGBO(241, 44, 109, 1.0),
      Color.fromRGBO(177, 80, 51, 1.0),
    ];

    if (!ranks.contains(rank)) {
      rank = "champion";
    }

    return colours[ranks.indexOf(rank)];
  }

  String firstLoggedInTime() {

    final DateTime firstLogin = DateTime.parse(widget.playerData.firstJoin);
    final Duration timeDifference = DateTime.now().difference(DateTime.parse(widget.playerData.firstJoin));
    late String lastLoggedInMessage;

    ///Seconds
    if (timeDifference.inSeconds < 60) {

      if (timeDifference.inSeconds == 1) {
        lastLoggedInMessage = "(1\u{00A0}Second\u{00A0}Ago)";
      } else {
        lastLoggedInMessage = "(${timeDifference.inSeconds}\u{00A0}Seconds\u{00A0}Ago)";
      }

    }
    ///Minutes
    if (timeDifference.inMinutes < 60) {

      if (timeDifference.inMinutes == 1) {
        lastLoggedInMessage = "(1\u{00A0}Minute\u{00A0}Ago)";
      } else {
        lastLoggedInMessage = "(${timeDifference.inMinutes}\u{00A0}Minutes\u{00A0}Ago)";
      }

    }
    ///Hours
    if (timeDifference.inHours < 24) {

      if (timeDifference.inHours == 1) {
        lastLoggedInMessage = "(1\u{00A0}Hour\u{00A0}Ago)";
      } else {
        lastLoggedInMessage = "(${timeDifference.inHours}\u{00A0}Hour\u{00A0}Ago)";
      }

    }
    ///Days
    if (timeDifference.inDays < 30) {

      if (timeDifference.inDays == 1) {
        lastLoggedInMessage = "(1\u{00A0}Day\u{00A0}Ago)";
      } else {
        lastLoggedInMessage = "(${timeDifference.inDays}\u{00A0}Days\u{00A0}Ago)";
      }

    }
    ///Months
    if (timeDifference.inDays < 365) {

      if (timeDifference.inDays >= 30 && timeDifference.inDays <= 31) {
        lastLoggedInMessage = "(1\u{00A0}Month\u{00A0}Ago)";
      } else {
        lastLoggedInMessage = "(${(timeDifference.inDays/30.437).toStringAsFixed(0)}\u{00A0}Months\u{00A0}Ago)";
      }

    }
    ///Years
    if (timeDifference.inDays >= 365) {

      if (timeDifference.inDays >= 365 && timeDifference.inDays < 730) {
        lastLoggedInMessage = "(1\u{00A0}Year\u{00A0}Ago)";
      } else {
        lastLoggedInMessage = "(${(((timeDifference.inDays)/30.437)/12).toStringAsFixed(0)}\u{00A0}Years\u{00A0}Ago)";
      }

    }

    return "${Jiffy.parse(firstLogin.toString()).format(pattern: "MMMM do yyyy")} $lastLoggedInMessage";
  }


  String lastLoggedInTime() {

    final Duration timeDifference = DateTime.now().difference(DateTime.parse(widget.playerData.lastJoin));
    late String lastLoggedInMessage;

    ///Seconds
    if (timeDifference.inSeconds < 60) {

      if (timeDifference.inSeconds == 1) {
        return lastLoggedInMessage = "Last seen: A second ago";
      }

      return lastLoggedInMessage = "Last seen: ${timeDifference.inSeconds} seconds ago";

    }
    ///Minutes
    if (timeDifference.inMinutes < 60) {

      if (timeDifference.inMinutes == 1) {
        return lastLoggedInMessage = "Last seen: A minute ago";
      }

      return lastLoggedInMessage = "Last seen: ${timeDifference.inMinutes} minutes ago";

    }
    ///Hours
    if (timeDifference.inHours < 24) {

      if (timeDifference.inHours == 1) {
        return lastLoggedInMessage = "Last seen: An hour ago";
      }

      return lastLoggedInMessage = "Last seen: ${timeDifference.inHours} hours ago";

    }
    ///Days
    if (timeDifference.inDays < 30) {

      if (timeDifference.inDays == 1) {
        return lastLoggedInMessage = "Last seen: A day ago";
      }

      return lastLoggedInMessage = "Last seen: ${timeDifference.inDays} days ago";

    }
    ///Months
    if (timeDifference.inDays < 365) {

      if (timeDifference.inDays >= 30 && timeDifference.inDays <= 60) {
        return lastLoggedInMessage = "Last seen: A month ago";
      }

      return lastLoggedInMessage = "Last seen: ${(timeDifference.inDays/30.437).toStringAsFixed(0)} months ago";

    }
    ///Years
    if (timeDifference.inDays >= 365) {

      if (timeDifference.inDays >= 365 && timeDifference.inDays < 730) {
        return lastLoggedInMessage = "Last seen: A year ago";
      }

      return lastLoggedInMessage = "Last seen: ${(((timeDifference.inDays)/30.437)/12).toStringAsFixed(0)} years ago";

    }

    return "Offline";
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
              child: Profile(),
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
                  width: 120.w,
                  height: 180.h,
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 4.h,
                          right: 18.0.w,
                          bottom: 14.h,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: FadeInImage(
                            placeholder:
                                const AssetImage("assets/images/stevemodel.png"),
                            image: NetworkImage(
                                'https://crafatar.com/renders/body/${widget.playerData.uuid}?overlay=true'),
                          ),
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
                              margin: const EdgeInsets.only(left: 10, top: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: widget.playerData.onlineStatus ==
                                        false
                                    ? const Color.fromRGBO(114, 114, 114, 1.0)
                                    : Colors.green,
                              ),
                              width: 12.w,
                              height: 12.w,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 8, top: 8),
                              child: Text(
                                widget.playerData.userName,
                                style: TextStyle(
                                  shadows: const [
                                    Shadow(
                                      offset: Offset(0.0, 1.0),
                                      blurRadius: 5.0,
                                      color: Color.fromRGBO(1, 1, 1, 1),
                                    ),
                                  ],
                                  color: chooseNameColour(
                                    widget.playerData.rank,
                                    widget.playerData.devRank,
                                  ),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 12.h, left: 4.w),
                              child: SvgPicture.network(
                                "https://cdn.wynncraft.com/${widget.playerData.rankBadgeUrl}",
                                height: 15,
                              ),
                            ),
                          ],
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, top: 1),
                            child: !widget.playerData.onlineStatus ? Text(
                              lastLoggedInTime(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ) : Text(
                              "Online on ${widget.playerData.currentServer}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, top: 1),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "First seen: ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    firstLoggedInTime(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
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
                height: 466,
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
