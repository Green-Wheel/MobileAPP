import 'package:flutter/material.dart';
import 'package:greenwheel/screens/home/widgets/bottom_bar.dart';
import 'package:greenwheel/screens/home/widgets/drawer.dart';
import 'package:greenwheel/screens/home/widgets/google_maps.dart';

import '../../widgets/language_selector_widget.dart';

class HomePage extends StatefulWidget {
  int publicationId;
  HomePage({Key? key,  this.publicationId = -1}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  void _onChangeTab(int index) {
    setState(() {
      this.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _searchTextField(), actions: [
        IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {});
            })
      ]),
      bottomNavigationBar: BottomBarWidget(
        index: index,
        onChangedTab: _onChangeTab,
      ),
      drawer: const SimpleDrawer(),
      floatingActionButton: const BottomBarActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        //TODO: Redireccionar a la pantalla de la publicación
        child: GoogleMapsWidget(index: index, key: UniqueKey(), publicationId: widget.publicationId),
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
