import 'dart:math';

import 'package:flutter/material.dart';
import '../../serializers/chargers.dart';
import '../../widgets/card_info.dart';
import '../services/backendServices/chargers.dart';

class InfiniteList extends StatefulWidget {
  const InfiniteList({Key? key}) : super(key: key);

  @override
  State<InfiniteList> createState() => _InfiniteList();

}

void main(){
  runApp(const MaterialApp(
    title: 'chargeInfo try',
    home: Scaffold(
      body: InfiniteList(),
    ),
  ));
}

class _InfiniteList extends State<InfiniteList>{
  @override
  Widget build(BuildContext context) {
    return buildPostsView();
  }

  late bool _isLastPage;
  late int _pageNumber;
  late bool _error;
  late bool _loading;
  final int _numberOfPostsPerRequest = 10;
  List<ChargerList> _markersList = [];
  List<ChargerList> _markersListAll = [];
  final int _nextPageTrigger = 3;

  @override
  void initState(){
    super.initState();
    _pageNumber = 1;
    _markersList = [];
    _isLastPage = false;
    _loading = true;
    _error = false;
    fetchData();
  }

  void _getChargersList(int page) async {
    List<ChargerList> chargerList = await ChargerService.getChargerList(page);
    print('chargeeeeeeer $chargerList');
    setState(() {
      //_markersList = chargerList;
      _markersListAll.addAll(chargerList);
    });
    print('markerLIiiist $_markersList');
    print('markerLIiiistAll $_markersListAll');
  }


  Future<void> fetchData() async {
    try {
      setState(() {
        _getChargersList(_pageNumber);
        _isLastPage = _markersListAll.length < _numberOfPostsPerRequest;
        _loading = false;
        _pageNumber = _pageNumber + 1;
        _markersListAll.addAll(_markersList);
      });
    } catch (e) {
      print("error --> $e");
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }

  Widget errorDialog({required double size}){
    return SizedBox(
      height: 180,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('An error occurred when fetching the posts.',
            style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.w500,
                color: Colors.black
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
              onPressed:  ()  {
                setState(() {
                  _loading = true;
                  _error = false;
                  fetchData();
                });
              },
              child: const Text("Retry", style: TextStyle(fontSize: 20, color: Colors.green),)),
        ],
      ),
    );
  }


  Widget buildPostsView() {
    if (_markersListAll.isEmpty) {
      if (_loading) {
        return const Center(
            child: Padding(
              padding: EdgeInsets.all(25),
              child: CircularProgressIndicator(),
            ));
      } else if (_error) {
        return Center(
          child: errorDialog(size: 20)
        );
      }
    }
    return ListView.builder(
      itemCount: _markersListAll.length + (_isLastPage ? 0 : 1),
      itemBuilder: (context, index) {
        if (index == _markersListAll.length - _nextPageTrigger) {
          fetchData();
        }
        if (index == _markersListAll.length) {
          if (_error) {
            return Center(
              child: errorDialog(size: 15)
            );
          } else {
            return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                )
            );
          }
        }
        //final ChargerList charger = _markersListAll[index];

        String? description = _markersListAll[index].title; // falta description al backend de ChargerList
        //description = title_parser(description);

        bool avaliable = true;

        List<ConnectionType> types = [];
        for (int i = 0; i < _markersListAll[index].connection_type.length; ++i) {
          types.add(_markersListAll[index].connection_type[i]);
        }

        bool match = true;

        return Flexible(child: _cardChargerList(description!, avaliable, match, types));
      });
  }

  //funcion respectiva a la card de los cargadores
  Widget _cardChargerList(String direction, bool avaliable, bool match, List<ConnectionType> types) {
    //Generación rate aleatoria (harcode rate)
    Random random = Random();
    int min = 2, max = 6;
    int num = (min + random.nextInt(max - min));
    double numd = num.toDouble();

    return CardInfoWidget(location: direction, rating: numd, types: types, available: avaliable, match: match);
  }



}