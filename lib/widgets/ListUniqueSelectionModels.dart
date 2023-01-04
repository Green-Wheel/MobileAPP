import 'package:flutter/material.dart';

import '../serializers/vehicles.dart';

class ListUniqueSelectionModels extends StatefulWidget {
  final String title;
  final List<CarModel> items;
  final String selectedItem;
  final Function(String) onChanged;

  ListUniqueSelectionModels({
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  _ListUniqueSelectionModelsState createState() => _ListUniqueSelectionModelsState();
}

class _ListUniqueSelectionModelsState extends State<ListUniqueSelectionModels> {
  late String _selectedItem;

  @override
  void initState() {
    _selectedItem = widget.selectedItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      trailing: DropdownButton<String>(
        value: _selectedItem,
        onChanged: (value) {
          setState(() {
            _selectedItem = value!;
            widget.onChanged(value);
          });
        },
        items: widget.items.map((item) {
          return DropdownMenuItem(
            value: item.name,
            child: Text(item.name),
          );
        }).toList(),
      ),
    );
  }
}
