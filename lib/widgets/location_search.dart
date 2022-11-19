import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import '../utils/address_autocompletation.dart';

class LocationSearch extends StatefulWidget {
  final Function submitSearch;

  const LocationSearch({Key? key, required this.submitSearch}) :super(key: key);

  @override
  State<LocationSearch> createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  final _searchController = TextEditingController();
  var _address = '';
  List<SearchFieldListItem> _suggestions = ['suggestion1', 'suggestion2']
      .map((e) => SearchFieldListItem(e))
      .toList();

  void getSuggestions(String input) async {
    var suggestions = await AdressAutocompletation.getAdresses(input);
    setState(() {
      _suggestions =
          suggestions.map((item) => SearchFieldListItem(item)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      final String text = _searchController.text.toLowerCase();
      if (_address != text) {
        getSuggestions(text);
        _address = text;
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchField(
      suggestions: _suggestions,
      onSubmit: (text) => widget.submitSearch(text),
      controller: _searchController,
    );
  }
}
