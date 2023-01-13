import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/services/backendServices/ratings.dart';
import 'package:greenwheel/widgets/rating_stars.dart';

import '../serializers/ratings.dart';
import '../serializers/users.dart';
import 'interactive_stars_widget.dart';


class BookingRatings extends StatefulWidget {

  BookingRatings({Key? key, required this.id}) : super(key: key);
  int id;
  @override
  State<BookingRatings> createState() => _BookingRatings();
}

class _BookingRatings extends State<BookingRatings> {

  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];
  Rating dummy = Rating(user: BasicUser(
      id: 2, username: "Miau", first_name: "Guau", last_name: "Crack"),
      rate: 3, comment: "Holasdsadsdasdsadsadasdsadasdsadasdasddasdsdadasdasdsa", created_at: DateTime.now());
  List  _ratings = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    List<Rating> aux = await RatingService.getRatingsPublication(widget.id);
    print("zzzzzzzzzzz");
    for(int i=0;i< aux.length;++i){
      print (aux[i]);
    }
    print(aux);
    setState(() {
      _ratings = aux;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("List of ratings of the publication") ,centerTitle: true),
      body:_buildBody(),
    );
  }

  Widget _buildBody() {
    int size = _ratings.length;
    double aux = 0;
    for(int i=0; i<size;++i){
      aux += _ratings[i].rate;
    }
    double avg = aux/size;
    return Container(
      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      padding: const EdgeInsets.only(top: 0, left: 0),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: const EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 0.0),
              child:Text("Valorations",style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold
                )
              )
            )
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width:42),
              Text("${avg.toStringAsFixed(3)}"),
              RatingStars(rating: (avg.toString()!=null) ?avg.toString() : "0"),
              Text("($size)")
            ],
          ),
          _getListViewWidget()],
      ),
    );
  }

  Widget _getListViewWidget() {
    return Flexible(
        child: ListView.builder(
            itemCount: _ratings.length,
            itemBuilder: (context, index) {
              final rating = _ratings[index];
              final MaterialColor color = _colors[index % _colors.length];
              return _getListItemWidget(rating, color);
            }));
  }

  CircleAvatar _getLeadingWidget(String userName, MaterialColor color) {
    return CircleAvatar(
      backgroundImage: const AssetImage('assets/images/default_user_img.jpg'),
      backgroundColor: color,
      child: Text(userName),
    );
  }
  Widget _getTitleWidget(String username, double rate) {
    return Align(
        alignment: Alignment.topLeft,
        child :Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Text(username, style: TextStyle(fontWeight: FontWeight.bold)),
              Align(
                alignment: Alignment.topLeft,
                child : RatingStars(rating: rate.toString()),
              ),
            ]
        )
    );
  }

  Widget _getCommentWidget(Rating rating) {
    String rate = rating.rate.toStringAsFixed(3);
    return Column(
      children: [
        Align(
            alignment: Alignment.topLeft,
            child :Row(
                children:[
                  Text(""),
                  SizedBox(width:10),
                  Align(
                    alignment: Alignment.topLeft,
                    child : Text(""),
                  ),
                  IconButton(
                    icon: Icon(Icons.report),
                    onPressed: () {
                     // int? aux = rating.user.id;
                    //  GoRouter.of(context).go('report/user/$aux');
                    },
                  )
                ]
            )
        ),
        Align(
          alignment: Alignment.topLeft,
          child :Text(rating.comment!,style: TextStyle(
              color: Colors.black),
          ),
        )
      ],
    );
  }


  ListTile _getListTile(Rating rating, MaterialColor color) {
    return ListTile(
      leading: _getLeadingWidget("",color),
      title: _getTitleWidget(rating.user.username,rating.rate),
      subtitle: _getCommentWidget(rating),
      isThreeLine: true,
    );
  }

  Container _getListItemWidget(Rating rating, MaterialColor color) {
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: Card(
        child: _getListTile(rating, color),
      ),
    );
  }
}

