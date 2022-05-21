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