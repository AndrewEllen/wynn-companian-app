import 'package:flutter/material.dart';


import '../constants.dart';

class ItemSearchContainer extends StatelessWidget {
  const ItemSearchContainer({super.key, required this.itemData});
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
      Color.fromRGBO(217, 0, 255, 0.7490196078431373),
      Color.fromRGBO(73, 239, 239, 0.75),
      Color.fromRGBO(175, 0, 0, 0.75),
      Color.fromRGBO(154, 27, 187, 0.7490196078431373),
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
            style: TextStyle(
              color: chooseNameColour(itemData["tier"].toLowerCase()),
              fontSize: 19,
              fontWeight: FontWeight.w700,
              shadows: const [
                Shadow(
                  offset: Offset(0.0, 1.0),
                  blurRadius: 2.0,
                  color: Color.fromRGBO(1, 1, 1, 1),
                ),
              ],
            ),
          ),
          subtitle: itemData["accessoryType"] == null ?
          Text(
            "${itemData["type"]}",
            style: const TextStyle(
              color: appGoldStatic1,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              shadows: [
                Shadow(
                  offset: Offset(0.0, 1.0),
                  blurRadius: 5.0,
                  color: Color.fromRGBO(1, 1, 1, 1),
                ),
              ],
            ),
          ) :
          Text(
            "${itemData["accessoryType"]}",
            style: const TextStyle(
              color: appGoldStatic1,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              shadows: [
                Shadow(
                  offset: Offset(0.0, 1.0),
                  blurRadius: 5.0,
                  color: Color.fromRGBO(1, 1, 1, 1),
                ),
              ],
            ),
          ),
          trailing: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: appTertiaryColour,
                width: 3,
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
            width: 50,
            height: 50,
            child: Container(
              margin: const EdgeInsets.only(top:4),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "${itemData["level"]}",
                      style: const TextStyle(
                        color: appGoldStatic1,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        shadows: [
                          Shadow(
                            offset: Offset(0.0, 1.0),
                            blurRadius: 5.0,
                            color: Color.fromRGBO(1, 1, 1, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Text(
                    "LVL",
                    style: TextStyle(
                      color: appGoldStatic1,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      shadows: [
                        Shadow(
                          offset: Offset(0.0, 1.0),
                          blurRadius: 5.0,
                          color: Color.fromRGBO(1, 1, 1, 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                child: itemData["accessoryType"] == null ?
                  Image.asset("assets/images/${itemData["type"].toLowerCase()}.webp") :
                  Image.asset("assets/images/${itemData["accessoryType"].toLowerCase()}.webp"),
              ),
              ),
            ),
          ),
      ),
    );
  }
}

