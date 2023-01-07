import 'package:flutter/material.dart';

import '../serializers/vehicles.dart';

class ListUniqueSelectionModels extends StatefulWidget {
  final String title;
  final List<CarModel> items;
  final int selectedItem;
  final Function(int) onChanged;

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
  late int _selectedItem;

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
            child: Text(item.name, style: const TextStyle(color: Colors.black)),
          );
        }).toList(),
      ),
    );
  }
}
