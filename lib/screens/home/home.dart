import 'package:flutter/material.dart';
import 'package:greenwheel/screens/home/widgets/bottom_bar.dart';
import 'package:greenwheel/screens/home/widgets/google_maps.dart';

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
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
              icon: const Icon(Icons.language), onPressed: _changeLanguage),
        ],
      ),
      body: SafeArea(
        child: GoogleMapsWidget(),
      ),
      bottomNavigationBar: BottomBarWidget(
        index: index,
        onChangedTab: _onChangeTab,
      ),
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
