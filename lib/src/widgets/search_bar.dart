import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  final TextEditingController _searchController;
  final Function(String) _performSearch;
  final FocusNode focusNode;

  MySearchBar(this._searchController, this._performSearch, this.focusNode);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: 'Search Event here...(eg:https://google.com)',
              ),
              onSubmitted: (value) {
                _performSearch(value);
              },
            ),
          ),
         Container(
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 240, 186, 106), 
    shape: BoxShape.rectangle,
  ),
  child: IconButton(
    icon: Icon(Icons.search),
    color: Colors.white, 
    onPressed: () {
      _performSearch(_searchController.text);
    },
  ),
)

        ],
      ),
    );
  }
}
