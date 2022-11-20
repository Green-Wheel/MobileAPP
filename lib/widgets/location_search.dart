import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import '../utils/address_autocompletation.dart';

class LocationSearch extends StatefulWidget {
  final Function submitSearch;
  var address;
  LocationSearch(
      {Key? key, required this.submitSearch, required this.address })
      : super(key: key);

  @override
  State<LocationSearch> createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  final _searchController = TextEditingController();
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
    _searchController.text = widget.address;
    _searchController.addListener(() {
      final String text = _searchController.text.toLowerCase();
      if (widget.address != text) {
        getSuggestions(text);
        widget.address = text;
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
