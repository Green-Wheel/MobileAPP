import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../serializers/bikes.dart';
import '../services/backendServices/bikes.dart';
import 'bike_card_info.dart';
import 'list_bike_filters_map.dart';

class BikeInfiniteList extends StatefulWidget {
  const BikeInfiniteList({Key? key}) : super(key: key);

  @override
  State<BikeInfiniteList> createState() => _BikeInfiniteList();

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

  void _showAvisNoEsPodenCarregarLlistaBicis() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bike Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Could not load bikes'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _getBikesList(int page) async {
    List<BikeList> bikeList = await BikeService.getBikeList(page);
    setState(() {
      _markersListAll.addAll(bikeList);
    });
  }

  void _getBikesListReset(int page) async {
    List<BikeList> bikeList = await BikeService.getBikeList(page);
    setState(() {
      removeMarkers();
      _markersListAll.addAll(bikeList);
    });
  }

  void _getBikesListByDate(int page) async {
    List<BikeList> bikeList = await BikeService.getBikesListByDate(page);
    setState(() {
      removeMarkers();
      _markersListAll.addAll(bikeList);
    });
  }

  void _getBikesListByProximity(int page) async {
    List<BikeList> chargerList = await BikeService.getBikesListByProximity(page);
    setState(() {
      removeMarkers();
      _markersListAll.addAll(chargerList);
    });
  }

  void _getNormalBikesList(int page) async {
    List<BikeList> chargerList = await BikeService.getNormalBikeList(page);
    setState(() {
      removeMarkers();
      _markersListAll.addAll(chargerList);
    });
  }

  void _getElectricBikesList(int page) async {
    List<BikeList> chargerList = await BikeService.getElectricBikeList(page);
    setState(() {
      removeMarkers();
      _markersListAll.addAll(chargerList);
    });
  }

  void removeMarkers() {
    List<BikeList> markersToRemove = [];
    _markersListAll = markersToRemove;
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
              child: const Text("Retry", style: TextStyle(fontSize: 20, color: Colors.blueAccent),)),
        ],
      ),
    );
  }

  Widget filtersList() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: ListBikeFilterMap(functionNormal: _getNormalBikesList,
          functionElectric: _getElectricBikesList,
          functionAll: _getBikesListReset,
          functionProximity: _getBikesListByProximity,
          functionDate: _getBikesListByDate)
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
    return Column(
        children: [
        filtersList(),
        Expanded(
          child: ListView.builder(
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
              BikeType bikeType = _markersListAll[index].bike_type as BikeType;
              String? direction = _markersListAll[index].title;
              double price = _markersListAll[index].price;
              bool available = true;
              int? id = _markersListAll[index].id;
              double? rate = _markersListAll[index].avg_rating;
              double latitude = _markersListAll[index].localization.latitude;
              double longitude = _markersListAll[index].localization.longitude;
              String? description = "Nice";
              String? direction1 = "Calle 1";
              int? owner_id = _markersListAll[index].owner.id;

              return Flexible(child:GestureDetector(
                onTap: () {
                  GoRouter.of(context)
                      .go('/bikes/$id');
                },
                child: BikeCardInfoWidget(location: direction, rating: rate, available: available, type: bikeType,
                    price: price, direction: direction1, description: description, bike_list: true, power: 0,
                    latitude: latitude, longitude: longitude, id: id, owner_id: owner_id),
              ));
            }
          )
        )
      ]
    );
  }
}