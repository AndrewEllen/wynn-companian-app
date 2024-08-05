import 'dungeonModel.dart';

class PlayerSearchModel {

  PlayerSearchModel({
    required this.userName,
    required this.uuid,

    this.rank = "",
    this.devRank = "",
    this.rankBadgeUrl = "",
    this.veteran = false,
    this.firstJoin = "",
    this.lastJoin = "",
    this.playTime = 0,
    this.guildName = "",
    this.guildPrefix = "",
    this.guildRank = "",
    this.guildRankStars = "",
    this.activeCharacter = "",
    this.onlineStatus = false,
    this.currentServer = "",
    this.forumLink = -1,
    this.numberOfWars = 0,
    this.numberOfRaids = 0,
    this.totalLevel = 0,
    this.killedMobs = 0,
    this.chestsFound = 0,
    this.totalDungeonsCompleted = 0,
    this.dungeonList = const [],
  });

  String userName;
  String uuid;

  String rank;
  String devRank;
  String rankBadgeUrl;
  bool veteran;
  String firstJoin;
  String lastJoin;
  double playTime;
  String guildName;
  String guildPrefix;
  String guildRank;
  String guildRankStars;
  String activeCharacter;
  bool onlineStatus;
  String currentServer;
  int forumLink;
  int numberOfWars;
  int numberOfRaids;
  int totalLevel;
  int killedMobs;
  int chestsFound;
  int totalDungeonsCompleted;
  List<DungeonModel> dungeonList;

}