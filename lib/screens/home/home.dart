import 'package:flutter/material.dart';
import 'package:greenwheel/screens/home/widgets/charger_filters_map.dart';
import 'package:greenwheel/screens/home/widgets/searchBar.dart';
import 'package:greenwheel/screens/home/widgets/bottom_bar.dart';
import 'package:greenwheel/screens/home/widgets/drawer.dart';
import 'package:greenwheel/screens/home/widgets/google_maps.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import '../../widgets/language_selector_widget.dart';

class HomePage extends StatefulWidget {
  int index;
  int publicationId;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar : false,
      appBar: SearchBar(index: widget.index == 1),
      bottomNavigationBar: BottomBarWidget(
        index: widget.index,
        onChangedTab: _onChangeTab,
      ),
      drawer: SimpleDrawer(),
      floatingActionButton: const BottomBarActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMapsWidget(index: widget.index, key: UniqueKey(), publicationId: widget.publicationId),
            ChargerFilterMap(functionPublic: () {}, functionPrivate: () {}, functionAll: () {}),
          ],
        ),
      ),
    );
  }

  void _changeLanguage() {
    showDialog(
      context: context,
      builder: (context) => const LanguageSelectorWidget(),
    );
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
}
