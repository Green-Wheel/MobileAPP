import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../serializers/chargers.dart';
import '../../../services/backendServices/user_service.dart';
import '../../../widgets/card_info.dart';
import 'InfiniteListUser.dart';


class MyPoints extends StatefulWidget {
  MyPoints(id, {Key? key}) : id = id, super(key: key);
  int id;
  @override
  State<MyPoints> createState() => MyPointsState();
}

class MyPointsState extends State<MyPoints> {
  List<Publication> publications = [];

  @override
  void initState() {
    super.initState();
    _getPublications();
  }

  void _getPublications() async {
    List<Publication> publicationlist = await UserService.getPostsUser(widget.id);
    if (publicationlist.isEmpty) {
      print("BBBBBBBBBBBB");
    }
    else {
      print("publication: $publicationlist");
      setState(() {
        publications = publicationlist;
        //obtenir ratings
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return InfiniteListUser(widget.id);
  }

}

