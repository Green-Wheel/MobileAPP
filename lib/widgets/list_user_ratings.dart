import 'package:flutter/material.dart';
import 'package:greenwheel/widgets/rating_stars.dart';

import '../serializers/ratings.dart';
import '../serializers/users.dart';
import 'interactive_stars_widget.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:comment_box/comment/test.dart';
import 'package:comment_box/main.dart';


class UserRatings extends StatefulWidget {

  UserRatings({Key? key}) : super(key: key);

  @override
  State<UserRatings> createState() => _UserRatings();
}

class _UserRatings extends State<UserRatings> {

  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];
  Rating dummy = Rating(user: BasicUser(
      id: 2, username: "Miau", first_name: "Guau", last_name: "Crack"),
      rate: 3, comment: "FIUM", created_at: DateTime.now());
  List _ratings = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() {
    setState(() {
      _ratings.add(dummy);
      _ratings.add(dummy);
      _ratings.add(dummy);
      _ratings.add(dummy);
      _ratings.add(dummy);
      _ratings.add(dummy);
      _ratings.add(dummy);
      _ratings.add(dummy);
      _ratings.add(dummy);
      _ratings.add(dummy);
      _ratings.add(dummy);
      _ratings.add(dummy);
      _ratings.add(dummy);
      _ratings.add(dummy);
      _ratings.add(dummy);
      _ratings.add(dummy);
      _ratings.add(dummy);
      _ratings.add(dummy);
      _ratings.add(dummy);
      _ratings.add(dummy);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      padding: const EdgeInsets.only(top: 0, left: 0),
      child: Column(
        children: <Widget>[
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

  Text _getTitleWidget(String username) {
    return Text(
      username,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _getCommentWidget(Rating rating) {
    String rate = rating.rate.toString();
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child :Row(
            children:[
              Text("1 " + "reseñas"),
              SizedBox(width:10),
              Align(
                alignment: Alignment.topLeft,
                child :RatingStars(rating: rate),
              ),
            ]
          )
        ),
        Align(
          alignment: Alignment.topLeft,
          child :Text(rating.comment!,style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.0),
          ),
        )
      ],
    );
  }

  ListTile _getListTile(Rating rating, MaterialColor color) {
    return ListTile(
      leading: _getLeadingWidget("", color),
      title: _getTitleWidget(rating.user.username),
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
