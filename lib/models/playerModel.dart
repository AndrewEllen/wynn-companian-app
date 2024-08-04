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
    this.guildPlayerRank = "",
    this.guildsRank = "",
    this.activeCharacter = "",
    this.onlineStatus = false,
    this.currentServer = "",
    this.forumLink = "",
    this.numberOfWars = 0,
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
  String guildPlayerRank;
  String guildsRank;
  String activeCharacter;
  bool onlineStatus;
  String currentServer;
  String forumLink;
  int numberOfWars;
  int totalLevel;
  int killedMobs;
  int chestsFound;
  int totalDungeonsCompleted;
  List<DungeonModel> dungeonList;

}