import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/page_change_provider.dart';
import '../screens/player_profile.dart';

class PlayerSearchContainer extends StatelessWidget {
  const PlayerSearchContainer({Key? key, required this.playerData}) : super(key: key);
  final List playerData;

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
          onTap: () => context.read<PageChange>().changePage(PlayerProfile(playerData: playerData,)),
          tileColor: appQuarternaryColour,
          title: Text(
            playerData[0],
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
                placeholder: AssetImage("assets/images/steve.png"),
                image: NetworkImage('https://crafatar.com/avatars/${playerData[1]}?overlay=true'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

