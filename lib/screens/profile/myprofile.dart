import 'package:flutter/material.dart';
import 'package:greenwheel/screens/profile/widgets/aboutMe.dart';
import 'package:greenwheel/screens/profile/widgets/infouser.dart';
import 'package:greenwheel/screens/profile/widgets/mypoints.dart';
import '../../services/generalServices/LoginService.dart';
import '../../widgets/list_user_ratings.dart';
import '../rating/user_rating_valoration.dart';


class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key, required id}) : id=id,super(key: key);
  int id;
  @override
  State<ProfilePage> createState() => _ProfilePage();

}

class _ProfilePage extends State<ProfilePage> {
  final _loggedInStateInfo = LoginService();
  var userData;

  @override
  void initState() {
    super.initState();
    _getData();
  }
  void _getData() async {
    var data = _loggedInStateInfo.user_info;
    setState(() {
      userData = data;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
              child: Column(
                children: <Widget> [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/4,
                      padding: const EdgeInsets.only(top:20),
                    child: InfoUser(widget.id),
                  ),
                  Container(
                      padding : const EdgeInsets.only(top:0),
                      decoration: const BoxDecoration(
                          border: Border(
                                    bottom: BorderSide(color: Colors.black),
                          ),
                      ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/8,
                    padding: const EdgeInsets.only(top:5),
                    child:  (userData['id'] == widget.id) ? AboutMe(userData['id']) : AboutMe(widget.id),//ficar user
                  ),
                  Container(
                    padding : const EdgeInsets.only(top:5),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  DefaultTabController(
                      length: 2, // length of tabs
                      initialIndex: 0,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                        const TabBar(
                          labelColor: Colors.green,
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            Tab(text: 'Posts'),
                            Tab(text: 'Ratings'),
                          ],
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height/2, //height of TabBarView
                            decoration: const BoxDecoration(
                                border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                            ),
                            child: TabBarView(children: <Widget>[
                              Container(
                                  padding: const EdgeInsets.only(top: 0, left: 10, right: 0),
                                  child:
                                  Column(
                                      children: <Widget>[
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("My Posts",
                                              style: TextStyle(
                                                  fontSize: 20, fontWeight: FontWeight.bold)),
                                        ),
                                        (userData['id'] == widget.id) ? MyPoints(userData['id']) : MyPoints(widget.id),
                                      ]
                                  )
                              ),
                              Container(
                                padding: const EdgeInsets.only(top:5),
                                child: UserRatings(widget.id)//RateUser(user_id: 2,booking_id: 2),
                              ),
                            ])
                        )
                      ])
                   ),
                  ],
                 ),

                // remaining stuffs
            ),
          );
        },
      )
    );
  }

}
