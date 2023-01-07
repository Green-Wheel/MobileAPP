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
  int _selectedItem = 1;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedItem = widget.selectedItem;
    });
    print('Selected item: $_selectedItem');
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      trailing: DropdownButton<int>(
        value: _selectedItem,
        dropdownColor: Colors.white,
        onChanged: (value) {
          setState(() {
            _selectedItem = value!;
            widget.onChanged(value);
          });
        },
        items: widget.items.map((item) {
          return DropdownMenuItem(
            value: item.id,
            child: item.year == null ? const Text('No year', style: TextStyle(color: Colors.black)) : Text(item.year.toString(), style: const TextStyle(color: Colors.black)),
          );
        }).toList(),
      ),
    );
  }
}
