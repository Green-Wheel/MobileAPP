import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenwheel/screens/home/widgets/bike_filters_map.dart';
import 'package:greenwheel/screens/home/widgets/charger_filters_map.dart';
import 'package:greenwheel/screens/home/widgets/searchBar.dart';
import 'package:greenwheel/screens/home/widgets/bottom_bar.dart';
import 'package:greenwheel/screens/home/widgets/drawer.dart';
import 'package:greenwheel/screens/home/widgets/google_maps.dart';
import '../../serializers/maps.dart';
import '../../widgets/language_selector_widget.dart';

class HomePage extends StatefulWidget {
  int index;
  int publicationId;
  var point_search = null;
  List<String> suggestions = [];
  HomePage({Key? key, this.index = 0, this.publicationId = -1}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _onChangeTab(int index) {
    setState(() {
      widget.index = index;
    });
  }

  final nameController = TextEditingController();

  void callBack (LatLang value, String selectioned) {
    setState(() {
      widget.point_search = value;
      print("--------------------");
      print(value);
      print("--------------------");
      if(!widget.suggestions.contains(selectioned)) widget.suggestions.add(selectioned);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar : false,
      appBar: SearchBar(index: widget.index, callBack: callBack, suggestions : widget.suggestions),
      bottomNavigationBar: BottomBarWidget(
        index: widget.index,
        onChangedTab: _onChangeTab,
      ),
      drawer: SimpleDrawer(),
      floatingActionButton: BottomBarActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: GoogleMapsWidget(index: widget.index, key: UniqueKey(), publicationId: widget.publicationId, point_search_bar: widget.point_search),
      ),
    );
  }
}

Widget _searchTextField() {
  return const TextField(
    autofocus: false,
    cursorColor: Colors.white,
    style: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
    textInputAction: TextInputAction.search,
    //Specify the action button on the keyboard
    decoration: InputDecoration(
      //Style of TextField
      hintText: "Search...", //Text that is displayed when nothing is entered.
      hintStyle: TextStyle(
        //Style of hintText
        color: Colors.white60,
        fontSize: 20,
      ),
      enabled: false,
    ),
  );
}
