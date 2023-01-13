import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/serializers/chargers.dart';
import 'package:greenwheel/services/backendServices/user_service.dart';

import '../../../serializers/bikes.dart';
import '../../../widgets/bike_card_info.dart';
import '../../../widgets/card_info.dart';


class InfiniteListUser extends StatefulWidget {
  InfiniteListUser(value,{Key? key}) : value =value,super(key: key);
  int value;

  @override
  State<InfiniteListUser> createState() => _InfiniteList();
}

class _InfiniteList extends State<InfiniteListUser> {

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              showButtonChargerFilter(),
              showButtonBikeFilter(),
            ]
          ),
          Container(
            height: MediaQuery.of(context).size.height/2.75,
            child: disableCharger&&disableBike? buildPostsView(_markersListAll): !disableCharger ? buildPostsView(bikesPublications): buildPostsView(chargerPublications) ,
          ),
        ]
      )
    );
  }

  List<Publication> chargerPublications = [];
  List<Publication> bikesPublications = [];
  late int _pageNumber;
  final int _numberOfPostsPerRequest = 10;
  List<Publication> _markersList = [];
  List<Publication> _markersListAll = [];
  bool pressFilterByChargers = false;
  bool pressFilterByBikes = false;
  bool disableCharger = true;
  bool disableBike = true;

  @override
  void initState() {
    super.initState();
    _pageNumber = 1;
    _markersList = [];
    fetchData();
  }

  void _showAvisNoEsPodenCarregarLlistaCarregadors() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Publication Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Could not load publications'),
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

  void _getPublicationList(int page) async {
    List<Publication> publicationlist = await UserService.getPostsUser(
        widget.value);
    if (publicationlist.isEmpty) {
      _showAvisNoEsPodenCarregarLlistaCarregadors();
    }
    else {
      for(int i=0;i<publicationlist.length;++i){
        if(publicationlist[i].type=="Charger") {
          chargerPublications.add(publicationlist[i]);
        } else {
          bikesPublications.add(publicationlist[i]);
        }
      }
    }
    setState(() {
      _markersListAll.addAll(publicationlist);
    });
  }


  Future<void> fetchData() async {
    try {
      setState(() {
        _getPublicationList(_pageNumber);
        _pageNumber = _pageNumber + 1;
        _markersListAll.addAll(_markersList);
      });
    } catch (e) {
      print("error --> $e");

    }
  }

  Widget errorDialog({required double size}) {
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
              onPressed: () {
                setState(() {
                  fetchData();
                });
              },
              child: const Text(
                "Retry", style: TextStyle(fontSize: 20, color: Colors.green),)),
        ],
      ),
    );
  }


  Widget buildPostsView(List<Publication> _markersListAll) {
    return ListView.builder(
        itemCount: _markersListAll.length,
        itemBuilder: (context, index) {
          if (_markersListAll[index].type == "Charger") {
            if (_markersListAll[index].charger != null) {
              double? rating = _markersListAll[index].charger?.avg_rating;
              String? description = _markersListAll[index].charger
                  ?.description;
              String? title = _markersListAll[index].charger?.title;
              int? id = _markersListAll[index].charger?.id;
              bool? avaliable = true;
              List<ConnectionType> types = [];
              for (int i = 0; i <
                  _markersListAll[index].charger!.connection_type.length; ++i) {
                types.add(_markersListAll[index].charger!.connection_type[i]);
              }
              bool private = _markersListAll[index].charger!.private != null
                  ? true
                  : false;
              bool match = true;
              double price = 10.0;
              if(_markersListAll[index].charger?.private != null) double price =_markersListAll[index].charger!.private!.price;
              String? direction = _markersListAll[index].charger?.direction;
              String? description2 = "";
              double latitude = _markersListAll[index].charger!.localization
                  .latitude;
              double longitude = _markersListAll[index].charger!.localization
                  .longitude;
              int? owner_id = _markersListAll[index].charger!.private?.owner.id;
              if (owner_id == null) {
                owner_id = 3;
              }
              String? owner_name = _markersListAll[index].charger!.private?.owner.username;
              if (owner_name == null){
                owner_name = "No owner";
              }
              String? contamination = _markersListAll[index].charger!.contamination;
              bool? compatible = _markersListAll[index].charger!.compatible;
              List? images = _markersListAll[index].charger!.images;

              return Flexible(child: _cardChargerList(rating,
                  description!, avaliable, match, types,
                  private, price, direction!, description2, id!, latitude,
                  longitude, owner_id, owner_name, contamination, compatible, images, title!));
            }
            else return Text("");
          }
          else {
            if (_markersListAll[index].bike != null) {
              BikeType bikeType = _markersListAll[index].bike!.bike_type;
              String? direction = _markersListAll[index].bike!.direction;
              String? title = _markersListAll[index].bike!.title;
              double price = _markersListAll[index].bike!.price;
              bool available = true;
              double power = _markersListAll[index].bike!.power ?? 0;
              int? id = _markersListAll[index].bike!.id;
              double? rate = _markersListAll[index].bike!.avg_rating;
              double latitude = _markersListAll[index].bike!.localization
                  .latitude;
              double longitude = _markersListAll[index].bike!.localization
                  .longitude;
              String? description = _markersListAll[index].bike!.description;
              String contamination = _markersListAll[index].bike!.contamination ?? '';
              String? direction1 = "";
              int? owner_id =  _markersListAll[index].bike!.owner.id;
              List? images = _markersListAll[index].bike!.images;
              double rating = 2.5;
              if(rate!=null) rating = rate;
              return Flexible(child: GestureDetector(
                onTap: () {
                  GoRouter.of(context)
                      .go('/bikes/$id');
                },
                child: BikeCardInfoWidget(location: title,
                    available: available,
                    type: bikeType,
                    price: price,
                    direction: direction1,
                    description: description,
                    bike_list: true,
                    power: power,
                    latitude: latitude,
                    longitude: longitude,
                    contamination: contamination,
                    id: id,
                    owner_id: owner_id,
                    images: images,
                    rating: double.parse((rating).toStringAsFixed(2))
                  ),
                )
              );
            }
            else return Text("");
          }
        }
    );
  }


  //funcion respectiva a la card de los cargadores
  Widget _cardChargerList(double? rating,String description, bool avaliable, bool match,
      List<ConnectionType> types, bool private, double price, String direction,
      String description2, int id, double latitude, double longitude, int? owner_id,
      String? owner_name, String? contamination, bool? compatible, List? images,String title
      ) {
    double rate = 2.5;
    if(rating != null) rate = rating;
    return GestureDetector(
      onTap: () {
        GoRouter.of(context)
            .go(
            '/chargers/$id'); //Navigator.push(context, MaterialPageRoute(builder: (context) => ChargerInfo()));
      },
      child:
          CardInfoWidget(location: title,
          rating: double.parse((rate).toStringAsFixed(2)),
          types: types,
          available: avaliable,
          match: match,
          private: false,
          price: price,
          direction: direction,
          description: description2,
          private_list: private,
          latitude: latitude,
          longitude: longitude,
          contamination: contamination,
          id: id,
          owner_id: owner_id,
          owner_username: owner_name,
          images: images,
      ),
    );
  }

  Widget showButtonChargerFilter() {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: pressFilterByChargers ? MaterialStateProperty.all<Color>(Colors.green[50]!) : MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<
              RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.5),
                  side: BorderSide(
                      color: pressFilterByChargers ? Colors.green : Colors.grey[700]!)
              )
          )
      ),
      onPressed: disableCharger ? () {
        setState(() {
          pressFilterByChargers = !pressFilterByChargers;
          disableBike = !disableBike;
        });
        if (pressFilterByChargers) {
          _getPublicationOfChargers();
        } else {
          _getAllPublications();
        }
      } : null,
      child: Row(
        children: [
          Icon(
            Icons.bolt,
            size: 20,
            color: pressFilterByChargers ? Colors.green : Colors.grey[700]!,
          ),
        ],
      ),
    );

  }

  Widget showButtonBikeFilter() {
      return TextButton(
        style: ButtonStyle(
            backgroundColor: pressFilterByBikes ? MaterialStateProperty.all<Color>(Colors.green[50]!) : MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<
                RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        7.5),
                    side: BorderSide(
                        color: pressFilterByBikes ? Colors.green : Colors.grey[700]!)
                )
            )
        ),
        onPressed: disableBike ? () {
          setState(() {
            pressFilterByBikes = !pressFilterByBikes;
            disableCharger = !disableCharger;
          });
          if (pressFilterByBikes) {
            _getPublicationOfBikes();
          } else {
            _getAllPublications();
          }
        } : null,
        child: Row(
          children: [
            Icon(
              Icons.directions_bike,
              size: 20,
              color: pressFilterByBikes ? Colors.green : Colors.grey[700]!,
            ),
          ],
        ),
      );
  }

  void _getPublicationOfChargers() {
    setState(() {
      chargerPublications = chargerPublications;
    });
  }
  void _getPublicationOfBikes() {
    setState(() {
      bikesPublications = bikesPublications;
    });
  }
  void _getAllPublications() {
    setState(() {
      _markersListAll = _markersListAll;
    });
  }

}
