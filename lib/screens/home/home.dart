import 'package:flutter/material.dart';
import 'package:greenwheel/screens/home/widgets/bottom_bar.dart';
import 'package:greenwheel/screens/home/widgets/drawer.dart';
import 'package:greenwheel/screens/home/widgets/google_maps.dart';

import '../../widgets/floating_search_bar.dart';
import '../../widgets/language_selector_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
/*
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(200, 200, 200, 1),
            toolbarHeight: 60.0,
            title: TextField(
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  hintText: " Search...",
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    color: Color.fromRGBO(93, 25, 72, 1),
                    onPressed: () {},
                  )),
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          ),
        //  Solució 1.

*/
      appBar: SearchBar(MediaQuery.of(context).size),
      body: SafeArea(
        child: GoogleMapsWidget(),
      ),
      bottomNavigationBar: BottomBarWidget(
        index: index,
        onChangedTab: _onChangeTab,
      ),
      drawer : SimpleDrawer(),
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
}
