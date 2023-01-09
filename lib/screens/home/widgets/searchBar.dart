import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenwheel/screens/home/widgets/google_maps.dart';
import 'package:greenwheel/utils/address_autocompletation.dart';

import '../../../utils/geocoding.dart';
import '../../../widgets/language_selector_widget.dart';
import '../home.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget{
  final int index;
  final Function callBack;
  SearchBar({Key? key, required this.index, required this.callBack }) :preferredSize = Size.fromHeight(kToolbarHeight),super(key: key);

  @override
  State<SearchBar> createState()=> _SearchBar();
  @override
  Size preferredSize;

}
class _SearchBar extends State<SearchBar>{
  String _selectioned = "";

  @override
  void initState() {
    super.initState();
    //_selectioned = DataSearch().getSelectioned();
  }

  void _changeLanguage() {
    showDialog(
      context: context,
      builder: (context) => const LanguageSelectorWidget(),
    );
  }


  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: const Text("Search"),//_searchTextField(),
        backgroundColor: widget.index==1 ? Colors.blue : Colors.green,
        actions:<Widget>[
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context:context,delegate:DataSearch(callBack : widget.callBack));
              }
          ),
          IconButton(
              icon: const Icon(Icons.language),
              onPressed: () {
                _changeLanguage();
              }
          )
        ]
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final Function callBack;

  DataSearch({Key? key, required this.callBack});

  String selectioned = "";

  var autocompletation = [];

  String getSelectioned(){
    return selectioned;
  }

  //List<String> autocompletation = AdressAutocompletation.getAdresses();
  final cities = [
    "Paris",
    "Lleida",
    "Barcelona",
    "Madrid",
    "Girona",
    "Sevilla",
    "Valencia",
    "Leon",
    "Vic"
  ];

  final recentCities = [
    "Paris",
    "Lleida",
    "Barcelona",
    "Madrid",
    "Girona"
  ];

  @override
  List<Widget> buildActions(BuildContext context){
    return [
      IconButton(icon: const Icon(Icons.clear),
          onPressed: (){
            query= "";
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed:(){
          close(context,"");
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero,() {
      close(context, "");
    });
    return Text("");
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    _getAdresses(query);
    return ListView.builder(
      itemBuilder: (context,index) => ListTile(
        onTap: () async {
          selectioned = autocompletation[index];
          print("-AAAAAAAAAAAAA  " + selectioned);
          query = autocompletation[index];
          _SearchBar()._selectioned = selectioned;
          callBack(await Geocoding.getLatLangFromAddress(selectioned));
          showResults(context);
        },
        leading: const Icon(Icons.location_city),
        title: RichText(
          text: TextSpan(text: autocompletation[index],
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      itemCount: autocompletation.length,
    );
  }
  void _getAdresses(String query) async {
    autocompletation = await AdressAutocompletation.getAdresses(query);
  }
}

