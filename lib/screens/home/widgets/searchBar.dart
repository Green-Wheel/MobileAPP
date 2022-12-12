import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/screens/home/widgets/google_maps.dart';
import 'package:greenwheel/utils/address_autocompletation.dart';
import 'package:greenwheel/utils/geocoding.dart';

import '../../../serializers/maps.dart';
import '../../../widgets/language_selector_widget.dart';
import '../../../widgets/location_search.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget{
  final bool index;
  SearchBar({Key? key, required this.index}) : preferredSize = Size.fromHeight(kToolbarHeight),super(key: key);

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
    _selectioned = DataSearch().getSelectioned();
  }
/*
  @override
  void SetState(){
    super.setState(() {
        _selectioned = DataSearch().selectioned;
    });
  }
*/
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
        backgroundColor: widget.index ? Colors.blue : Colors.green,
        actions:<Widget>[
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context:context,delegate:DataSearch());
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
  String selectioned = "";

  String getSelectioned(){
    return selectioned;
  }

  Future<List<String>>getAdresses(String str) async {
    List<String> autocompletation = await AdressAutocompletation.getAdresses(str);
    return autocompletation;
  }

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
    //Aqui enviar al mapa les coordenades
    close(context,"");
    return Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final autocompletation = query.isEmpty?recentCities: cities.where((p)=>p.startsWith(query)).toList();

    //List<String> autocompletation2 = getAdresses(query.characters);
    //print(autocompletation2);
    print("------------------------------- : ${autocompletation.length}");
    return LocationSearch(
      submitSearch: submitAddress,
      address: query,
    );
  }

  void submitAddress(value) async {
    LatLang? prov = await Geocoding.getLatLangFromAddress(value);
    Address? address = await Geocoding.getAddressFromLatLang(prov!);

    setPointAddress(prov, address!);
  }
  void setPointAddress(LatLang point, Address address) {
    //GoogleMapsWidget
  }
}

