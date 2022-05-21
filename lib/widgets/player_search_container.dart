import 'package:flutter/material.dart';
import 'package:wynn_companian_app/constants.dart';

class PlayerSearchContainer extends StatelessWidget {
  const PlayerSearchContainer({Key? key, required this.playerData}) : super(key: key);
  final List playerData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
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
          tileColor: appQuarternaryColour,
          title: Text(playerData[0]),
          leading: Container(
            width: 40,
            height: 40,
            color: Colors.transparent,
            child: FadeInImage(
              placeholder: AssetImage("assets/images/steve.png"),
              image: NetworkImage('https://crafatar.com/avatars/${playerData[1]}'),
            ),
          ),
        ),
      ),
    );
  }
}

