import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
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

  NumberFormat formatterDecimal = NumberFormat.decimalPatternDigits(
    locale: 'en_us',
    decimalDigits: 2,
  );

  NumberFormat formatter = NumberFormat.decimalPatternDigits(
    locale: 'en_us',
    decimalDigits: 0,
  );

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
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 2,
                        bottom: 1,
                        left: 2,
                        right: 1,
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
                              padding: EdgeInsets.all(2.h),
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
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 2,
                        bottom: 1,
                        left: 1,
                        right: 2,
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
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  widget.playerData.rankBadgeUrl.isNotEmpty ? Padding(
                                    padding: EdgeInsets.only(
                                      top: 10.h,
                                      left: 10.w,
                                    ),
                                    child: SvgPicture.network(
                                      "https://cdn.wynncraft.com/${widget.playerData.rankBadgeUrl}",
                                      height: 15,
                                    ),
                                  ) : const SizedBox.shrink(),
                                  Padding(
                                    padding: EdgeInsets.only(top: widget.playerData.rankBadgeUrl.isEmpty ? 8.0 : 0),
                                    child: Row(
                                      children: [
                                        !widget.playerData.onlineStatus ? Container(
                                          margin: EdgeInsets.only(left: 10.w),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromRGBO(114, 114, 114, 1.0),
                                          ),
                                          width: 12.w,
                                          height: 12.w,
                                        ) :
                                        Container(
                                          width: 12.w,
                                          height: 12.w,
                                          margin: EdgeInsets.only(left: 10.w),
                                          child: AvatarGlow(
                                            glowCount: 2,
                                            startDelay: const Duration(milliseconds: 1000),
                                            glowColor: Colors.greenAccent,
                                            glowShape: BoxShape.circle,
                                            animate: true,
                                            curve: Curves.fastOutSlowIn,
                                            child: const Material(
                                              elevation: 8.0,
                                              shape: CircleBorder(),
                                              color: Colors.transparent,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.green,
                                                radius: 12,
                                              ),
                                            ),
                                          ),
                                        ),

                                        Container(
                                          margin: EdgeInsets.only(left: 6.w),
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              IntrinsicHeight(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(left: 10, top: 1),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(

                                          [for (int i = 0; i < widget.playerData.guildRankStars.length/3; i++) {
                                            "\u2605"
                                          }].join("").replaceAll(RegExp(r"\p{P}", unicode: true), ""),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),

                                      Flexible(
                                        child: Text(
                                          "${widget.playerData.guildRank} of ${widget.playerData.guildName}",
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

                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left: 10, top: 12.h),
                                  child: !widget.playerData.onlineStatus ? Text(
                                    lastLoggedInTime(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ) : Text(
                                    "Online on ${widget.playerData.currentServer}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
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
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          firstLoggedInTime(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
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
              
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.maxFinite,
                margin: const EdgeInsets.only(
                  top: 1,
                  bottom: 2,
                  left: 2,
                  right: 2,
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

                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Flexible(
                            child: RichText(
                              text: TextSpan(
                                text: "Total Level: ",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: "${formatter.format(widget.playerData.totalLevel)} Levels",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ]
                              ),
                            ),
                        ),

                        Flexible(
                          child: RichText(
                            text: TextSpan(
                                text: "Total Playtime: ",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: "${formatterDecimal.format(widget.playerData.playTime)} Hours",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ),

                        Flexible(
                          child: RichText(
                            text: TextSpan(
                                text: "Total Mobs Killed: ",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: "${formatter.format(widget.playerData.killedMobs)} Mobs",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ),

                        Flexible(
                          child: RichText(
                            text: TextSpan(
                                text: "Total Chests Looted: ",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: "${formatter.format(widget.playerData.chestsFound)} Chests",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ),

                        SizedBox(height: 12.h),

                        Flexible(
                          child: RichText(
                            text: TextSpan(
                                text: "Total Wars Fought: ",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: "${formatter.format(widget.playerData.numberOfWars)} Wars",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ),

                        Flexible(
                          child: RichText(
                            text: TextSpan(
                                text: "Total Raids Completed: ",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: "${formatter.format(widget.playerData.numberOfRaids)} Raids",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ),

                        Flexible(
                          child: RichText(
                            text: TextSpan(
                                text: "Total Dungeons Completed: ",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: "${formatter.format(widget.playerData.totalDungeonsCompleted)} Dungeons",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ]
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
