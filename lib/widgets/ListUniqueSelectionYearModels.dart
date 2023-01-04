import 'package:flutter/material.dart';

import '../serializers/vehicles.dart';

class ListUniqueSelectionYearModels extends StatefulWidget {
  final String title;
  final List<CarBrandYear> items;
  final int selectedItem;
  final Function(int) onChanged;

  ListUniqueSelectionYearModels({
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  _ListUniqueSelectionYearModelsState createState() => _ListUniqueSelectionYearModelsState();
}

class _ListUniqueSelectionYearModelsState extends State<ListUniqueSelectionYearModels> {
  late int _selectedItem;

  @override
  void initState() {
    _selectedItem = widget.selectedItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      trailing: DropdownButton<int>(
        value: _selectedItem,
        onChanged: (value) {
          setState(() {
            _selectedItem = value!;
            widget.onChanged(value);
          });
        },
        items: widget.items.map((item) {
          return DropdownMenuItem(
            value: item.year,
            child: Text(item.year.toString()),
          );
        }).toList(),
      ),
    );
  }
}
