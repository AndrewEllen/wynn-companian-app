import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wynn_companian_app/constants.dart';

import '../providers/page_change_provider.dart';

class ItemSearchContainer extends StatelessWidget {
  const ItemSearchContainer({Key? key, required this.itemData}) : super(key: key);
  final List itemData;

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
            itemData[0],
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
              child: FadeInImage(
                placeholder: AssetImage("assets/images/steve.png"),
                image: NetworkImage('https://crafatar.com/avatars/${itemData[1]}?overlay=true'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

