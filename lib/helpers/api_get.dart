import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/player.dart';

SearchPlayers(String searchParameter) async {
    final response = await http
        .get(Uri.parse('https://api.wynncraft.com/public_api.php?action=statsSearch&search=$searchParameter'));

    if (response.statusCode == 200) {
        var snapshot = jsonDecode(response.body);

        return snapshot["players"];
    } else {
        throw Exception("Failed to Load");
    }
}

SearchUUID(String searchParameter) async {
    final response = await http
        .get(Uri.parse('https://api.mojang.com/users/profiles/minecraft/$searchParameter'));

    if (response.statusCode == 200) {
        var snapshot = jsonDecode(response.body);
        return snapshot["id"];
    } else {
        throw Exception("Failed to Load");
    }
}

SearchUserStats(String searchParameter) async {

    var i = 0;
    final dashes = {2, 3, 4, 5};

    final dashedSearchParameter = searchParameter.splitMapJoin(RegExp('....'), onNonMatch: (s) => dashes.contains(i++)? '-' : '');

    final response = await http
        .get(Uri.parse('https://api.wynncraft.com/v2/player/$dashedSearchParameter/stats'));

    if (response.statusCode == 200) {
        var snapshot = jsonDecode(response.body);
        return snapshot["data"];
    } else {
        throw Exception("Failed to Load");
    }
}