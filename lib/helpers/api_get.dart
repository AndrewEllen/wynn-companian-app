import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

SearchPlayers(String searchParameter) async {

    debugPrint(searchParameter);

    final http.Response response = await http
        .get(Uri.parse('https://api.wynncraft.com/v3/search/$searchParameter'));

    debugPrint("Searched");

    if (response.statusCode == 200) {

        debugPrint("Processing Response");

        var snapshot = json.decode(response.body);

        return snapshot["players"];
    } else {
        throw Exception("Failed to Load");
    }
}

SearchUUID(String searchParameter) async {
    final response = await http
        .get(Uri.parse('https://api.mojang.com/users/profiles/minecraft/$searchParameter?only=players'));

    if (response.statusCode == 200) {
        var snapshot = jsonDecode(response.body);
        return snapshot["id"];
    } else {
        throw Exception("Failed to Load");
    }
}

SearchUserStats(String searchParameter) async {

    final response = await http
        .get(Uri.parse('https://api.wynncraft.com/v3/player/$searchParameter?fullResult'));

    if (response.statusCode == 200) {
        var snapshot = json.decode(response.body);
        return snapshot;
    } else {
        throw Exception("Failed to Load");
    }
}


SearchItems(String itemNameSearchParameter, String itemCategorySearchParameter) async {
    late String url;
    if (itemNameSearchParameter.isEmpty) {
        url = 'https://api.wynncraft.com/public_api.php?action=itemDB&category=$itemCategorySearchParameter';
    } else {
        url = 'https://api.wynncraft.com/public_api.php?action=itemDB&search=$itemNameSearchParameter&category=$itemCategorySearchParameter';
    }

    final response = await http
        .get(Uri.parse(url));

    if (response.statusCode == 200) {
        var snapshot = jsonDecode(response.body);
        return snapshot["items"];
    } else {
        throw Exception("Failed to Load");
    }
}