import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/utils/address_autocompletation.dart';

import '../../../widgets/language_selector_widget.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget{
  SearchBar({Key? key}) : preferredSize = Size.fromHeight(kToolbarHeight),super(key: key);

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
            title: Text("Search"),//_searchTextField(),
            actions:<Widget>[
                IconButton(
                   icon: Icon(Icons.search),
                   onPressed: () {
                       //showSearch(context:context,delegate:DataSearch());
                   }
                 ),
                IconButton(
                    icon: Icon(Icons.language),
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
      IconButton(icon: Icon(Icons.clear),
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
    //final suggestionList = query.isEmpty?recentCities: cities.where((p)=>p.startsWith(query)).toList();
    List<String> autocompletation = AdressAutocompletation.getAdresses("") as List<String>;
    print("------------------------------- : "  + autocompletation.length.toString());
    return ListView.builder(
      itemBuilder: (context,index) => ListTile(
        onTap: (){
          selectioned = autocompletation[index];
          query = autocompletation[index];
          _SearchBar()._selectioned = selectioned;
          print("------------------------------- : "  + _SearchBar()._selectioned);
          print("------------------------------- : "  + selectioned);
          showResults(context);
        },
        leading: Icon(Icons.location_city),
        title: RichText(
          text: TextSpan(text: autocompletation[index].substring(0,query.length),
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children:  [
                TextSpan(text: autocompletation[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]
          ),
        ),
      ),
      itemCount: autocompletation.length,
    );
  }
}