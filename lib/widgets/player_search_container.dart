import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wynncraft_companion_app/models/playerModel.dart';

import '../constants.dart';
import '../providers/page_change_provider.dart';
import '../screens/player_profile.dart';

class PlayerSearchContainer extends StatelessWidget {
  const PlayerSearchContainer({super.key, required this.playerData});
  final PlayerSearchModel playerData;

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
          onTap: () => context.read<PageChange>().changePageCache(PlayerProfile(playerData: playerData,)),
          tileColor: appQuarternaryColour,
          title: Text(
            playerData.userName,
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
                image: NetworkImage('https://crafatar.com/avatars/${playerData.uuid}?overlay=true'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

