import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wynn_companian_app/constants.dart';
import '../providers/item_search_provider.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController searchController = TextEditingController();
  late GlobalKey<FormState> searchKey = GlobalKey<FormState>();

  bool _isSelected = true;

  void SaveItemNameForSearch() {
    context.read<ItemSearchProvider>().updateItem(searchController.text);
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void initState() {
    if (context.read<ItemSearchProvider>().itemSearchName.isNotEmpty) {
      searchController.text = context.read<ItemSearchProvider>().itemSearchName;
      _isSelected = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width/1.25,
          maxHeight: 22,
        ),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: appTertiaryColour,
          ),
          child: Row(
            children: [
              Container(
                height: 22,
                width: MediaQuery.of(context).size.width/1.39,
                padding: const EdgeInsets.only(top: 1, left: 8),
                child: Form(
                  child: Focus(
                    onFocusChange: (isFocused) {
                      if(isFocused) {
                        searchController.selection = TextSelection(baseOffset: 0, extentOffset: searchController.text.length);
                        setState(() {
                          _isSelected = true;
                        });
                      } else if(searchController.text.isNotEmpty) {
                        setState(() {
                          _isSelected = false;
                        });
                      }
                    },
                    child: TextFormField(
                      controller: searchController,
                      key: searchKey,
                      textInputAction: TextInputAction.search,
                      onEditingComplete: SaveItemNameForSearch,
                      cursorColor: appGoldStatic1,
                      textAlign: _isSelected ? TextAlign.left : TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration.collapsed(
                        hintText: "Enter Item Name...",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(FocusNode()),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(left: BorderSide(color: Colors.black)),
                ),
                height: 22,
                width: MediaQuery.of(context).size.width/13,
                child: Center(
                  child: IconButton(
                    padding: const EdgeInsets.only(top:0.5),
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 22,
                    ),
                    onPressed: SaveItemNameForSearch,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
