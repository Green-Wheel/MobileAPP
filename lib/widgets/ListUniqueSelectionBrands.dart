import 'package:flutter/material.dart';
import '../serializers/vehicles.dart';

class ListUniqueSelectionBrands extends StatefulWidget {
  final String title;
  final List<CarBrand> items;
  final int selectedItemId;
  final Function(int) onChanged;

  ListUniqueSelectionBrands({
    required this.title,
    required this.items,
    required this.selectedItemId,
    required this.onChanged,
  });

  @override
  _ListUniqueSelectionBrandsState createState() => _ListUniqueSelectionBrandsState();
}

class _ListUniqueSelectionBrandsState extends State<ListUniqueSelectionBrands> {
  int _selectedItemId = 1;

  @override
  void initState() {
    //_selectedItemId = widget.selectedItemId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      trailing: DropdownButton<int>(
        value: _selectedItemId,
        dropdownColor: Colors.white,
        onChanged: (value) {
          setState(() {
            _selectedItemId = value!;
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
