import 'package:flutter/material.dart';
import 'package:greenwheel/screens/home/widgets/bottom_bar.dart';
import 'package:greenwheel/screens/home/widgets/drawer.dart';
import 'package:greenwheel/screens/home/widgets/google_maps.dart';

import '../../widgets/language_selector_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: _searchTextField(),
          leading: new IconButton(
            icon: new Icon(Icons.account_circle),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          backgroundColor: Colors.green , actions: [
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {});
            })
      ]),
      body: SafeArea(
        child: GoogleMapsWidget(),
      ),
      bottomNavigationBar: BottomBarWidget(
        index: index,
        onChangedTab: _onChangeTab,
      ),
      drawer: SimpleDrawer(),
      floatingActionButton: const BottomBarActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _changeLanguage() {
    showDialog(
      context: context,
      builder: (context) => const LanguageSelectorWidget(),
    );
  }

  void _onChangeTab(int index) {
    setState(() {
      this.index = index;
    });
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
        hintText: 'Search...', //Text that is displayed when nothing is entered.
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
