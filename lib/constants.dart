import 'package:flutter/material.dart';

const Color appPrimaryColour = Color.fromRGBO(9, 9, 9, 1.0);
const Color appSecondaryColour = Color.fromRGBO(0, 190, 34, 1.0);
const Color appTertiaryColour = Color.fromRGBO(98, 78, 60, 1.0);
const Color appQuarternaryColour = Color.fromRGBO(156, 136, 104, 1.0);
const Color appQuinaryColour = Color.fromRGBO(57, 57, 57, 1.0);


const Color appGoldStatic1 = Color.fromRGBO(215, 215, 7, 1.0);
const Color appGoldStatic2 = Color.fromRGBO(156, 156, 7, 1.0);

const LinearGradient appGold = LinearGradient(
    colors: [
      Color.fromRGBO(156, 156, 7, 1.0),
      Color.fromRGBO(199,198,0,1.0),
      Color.fromRGBO(156, 156, 7, 1.0),
    ],
);

final Color streakColourOrange = Colors.deepOrange;
final Color streakColourGrey = Colors.grey;

const BoxDecoration homeBoxDecoration = BoxDecoration(
  color: appTertiaryColour,
  borderRadius: BorderRadius.all(Radius.circular(4)),
);