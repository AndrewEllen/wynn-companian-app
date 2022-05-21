import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/player.dart';

SearchPlayers(String searchParameter) async {
    final response = await http
        .get(Uri.parse('https://api.wynncraft.com/public_api.php?action=statsSearch&search=$searchParameter'));

    if (response.statusCode == 200) {
        var snapshot = jsonDecode(response.body);
        print(snapshot["players"]);
        print(snapshot["players"].runtimeType);
        return snapshot["players"];
    } else {
        throw Exception("Failed to Load");
    }

    //print(snapshot["players"]);
    //print(snapshot["players"].runtimeType);

    /*if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }*/
}