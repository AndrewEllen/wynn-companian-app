import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wynncraft_companion_app/models/playerModel.dart';

import '../constants.dart';
import '../helpers/api_get.dart';
import '../providers/page_change_provider.dart';
import '../screens/player_profile.dart';

class PlayerSearchContainer extends StatelessWidget {
  PlayerSearchContainer({super.key, required this.playerSearchData});
  late PlayerSearchModel playerSearchData;


  fetchStatsData(PlayerSearchModel playerData) async {
    final playerStatsData = await SearchUserStats(playerData.userName);

    debugPrint(playerStatsData.toString());

    playerData.rank = playerStatsData["supportRank"] ?? "";
    playerData.devRank = playerStatsData["rank"] ?? "player";
    playerData.rankBadgeUrl = playerStatsData["rankBadge"] ?? "";
    playerData.veteran = playerStatsData["veteran"] ?? false;
    playerData.firstJoin = playerStatsData["firstJoin"] ?? "";
    playerData.lastJoin = playerStatsData["lastJoin"] ?? "";
    playerData.playTime = playerStatsData["playtime"] ?? 0;
    playerData.guildName = playerStatsData["guild"] != null ? playerStatsData["guild"]["name"] ?? "" : "";
    playerData.guildPrefix = playerStatsData["guild"] != null ? playerStatsData["guild"]["prefix"] ?? "" : "";
    playerData.guildRank = playerStatsData["guild"] != null ? playerStatsData["guild"]["rank"] ?? "" : "";
    playerData.guildRankStars = playerStatsData["guild"] != null ? playerStatsData["guild"]["rankStars"] ?? "" : "";
    playerData.activeCharacter = playerStatsData["activeCharacter"] ?? "";
    playerData.onlineStatus = playerStatsData["online"] ?? false;
    playerData.currentServer = playerStatsData["server"] ?? "";
    playerData.forumLink = playerStatsData["forumLink"] ?? -1;
    playerData.numberOfWars = playerStatsData["globalData"]["wars"] ?? 0;
    playerData.totalLevel = playerStatsData["globalData"]["totalLevel"] ?? 0;
    playerData.killedMobs = playerStatsData["globalData"]["killedMobs"] ?? 0;
    playerData.chestsFound = playerStatsData["globalData"]["chestsFound"] ?? 0;
    playerData.totalDungeonsCompleted = playerStatsData["globalData"]["dungeons"]["total"] ?? 0;
    playerData.dungeonList = [];

    return playerData;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top:5,
        bottom: 5,
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
        child: ListTile(
          onTap: () async {
            PlayerSearchModel playerData = await fetchStatsData(playerSearchData);
            if (context.mounted) {
              context.read<PageChange>().changePageCache(PlayerProfile(playerData: playerData,));
            }
          },
          tileColor: appQuarternaryColour,
          title: Text(
            playerSearchData.userName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          leading: Container(
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
              width: 40,
              height: 40,
              child: FadeInImage(
                placeholder: const AssetImage("assets/images/steve.png"),
                image: NetworkImage('https://crafatar.com/avatars/${playerSearchData.uuid}?overlay=true'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

