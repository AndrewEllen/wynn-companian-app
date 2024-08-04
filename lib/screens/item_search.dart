import 'package:flutter/material.dart';
import '../helpers/api_get.dart';
import '../providers/item_search_provider.dart';
import '../providers/player_search_provider.dart';
import '../widgets/background_container.dart';
import '../constants.dart';
import 'package:provider/provider.dart';
import '../widgets/item_search_container.dart';
import '../widgets/player_searchbar.dart';

class ItemSearchScreen extends StatefulWidget {
  const ItemSearchScreen({super.key});

  @override
  State<ItemSearchScreen> createState() => _ItemSearchScreenState();
}

class _ItemSearchScreenState extends State<ItemSearchScreen> {
  late var ItemSearchData;

  SearchItemDatabase() async {
    ItemSearchData = [];
    ItemSearchData = await SearchItems(
      context.read<ItemSearchProvider>().itemSearchName,
      "all",
    );
    return ItemSearchData;
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ItemSearchProvider>().itemSearchName;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appPrimaryColour,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: BackgroundContainer(
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 22),
                child: const WynnSearchBar(),
              ),
              FutureBuilder(
                future: SearchItemDatabase(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    if (context.read<PlayerSearchProvider>().playerSearchName.isNotEmpty) {
                      return Center(
                        child: Container(
                          margin: const EdgeInsets.only(top:30),
                          width: MediaQuery.of(context).size.width/1.25,
                          height: 10,
                          child: const ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            child: LinearProgressIndicator(
                              color: appGoldStatic2,
                              backgroundColor: appGoldStatic1,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  } else {
                    return Container(
                      margin: const EdgeInsets.only(top:5),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height/1.22,
                      child: ListView.builder(
                        itemCount: ItemSearchData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemSearchContainer(
                            itemData: ItemSearchData[index],
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
