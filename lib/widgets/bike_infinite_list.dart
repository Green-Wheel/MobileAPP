import 'dart:math';

import 'package:flutter/material.dart';
import '../serializers/bikes.dart';
import '../services/backendServices/bikes.dart';
import 'bike_card_info.dart';

class BikeInfiniteList extends StatefulWidget {
  const BikeInfiniteList({Key? key}) : super(key: key);

  @override
  State<BikeInfiniteList> createState() => _BikeInfiniteList();

}

void main(){
  runApp(const MaterialApp(
    title: 'chargeInfo try',
    home: Scaffold(
      body: BikeInfiniteList(),
    ),
  ));
}

class _BikeInfiniteList extends State<BikeInfiniteList>{
  @override
  Widget build(BuildContext context) {
    return buildPostsView();
  }

  late bool _isLastPage;
  late int _pageNumber;
  late bool _error;
  late bool _loading;
  final int _numberOfPostsPerRequest = 10;
  List<BikeList> _markersList = [];
  List<BikeList> _markersListAll = [];
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

  void _getBikesList(int page) async {
    List<BikeList> bikeList = await BikeService.getBikeList(page);
    setState(() {
      //_markersList = chargerList;
      _markersListAll.addAll(bikeList);
    });
  }


  Future<void> fetchData() async {
    try {
      setState(() {
        _getBikesList(_pageNumber);
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

          BikeType bikeType = _markersListAll[index].bike_type;

          return Flexible(child: _cardBikeList(description!, avaliable, bikeType));
        });
  }

  //funcion respectiva a la card de los cargadores
  Widget _cardBikeList(String direction, bool available, BikeType bikeType){
    //Generación rate aleatoria (harcode rate)
    Random random = Random();
    int min = 2, max = 6;
    int num = (min + random.nextInt(max - min));
    double numd = num.toDouble();

    return BikeCardInfoWidget(location: direction, rating: numd, available: available, bikeType: bikeType);
  }
}