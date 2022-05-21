import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wynn_companian_app/constants.dart';

import '../providers/page_change_provider.dart';

class ItemSearchContainer extends StatelessWidget {
  ItemSearchContainer({Key? key, required this.itemData}) : super(key: key);
  final Map itemData;

  chooseNameColour(String tier) {
    List<String> tiers = [
      "normal",
      "unique",
      "set",
      "rare",
      "legendary",
      "fabled",
      "mythic",
    ];

    List<Color> colours = const [
      Color.fromRGBO(255, 255, 255, 0.75),
      Color.fromRGBO(255, 226, 37, 0.7490196078431373),
      Color.fromRGBO(49, 226, 49, 0.75),
      Color.fromRGBO(73, 239, 239, 0.75),
      Color.fromRGBO(175, 0, 0, 0.75),
      Color.fromRGBO(207, 19, 241, 0.75),
      Color.fromRGBO(150, 0, 163, 0.75),
    ];

    return colours[tiers.indexOf(tier)];
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
          tileColor: appQuarternaryColour,
          title: Text(
            itemData["name"],
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
                color: Colors.transparent,
              ),
              width: 40,
              height: 40,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      appQuinaryColour,
                      chooseNameColour(itemData["tier"].toLowerCase()),
                      appQuinaryColour,
                    ],
                  ),
                ),
                child: Image.asset("assets/images/${itemData["accessoryType"].toLowerCase()}.webp"),
              ),
              ),
            ),
          ),
      ),
    );
  }
}

