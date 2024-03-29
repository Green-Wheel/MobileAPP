import 'package:flutter/material.dart';
import 'package:greenwheel/services/backendServices/ratings.dart';
import '../register/widgets/greenButton.dart';
import '../../services/generalServices/LoginService.dart';
import '../../widgets/interactive_stars_widget.dart';


class RateBooking extends StatefulWidget {
  RateBooking({Key? key,required int this.publication_id, required int this.booking_id,}) : super(key: key);
  int booking_id;
  int publication_id;

  @override
  State<RateBooking> createState() => _RateBooking();
}

class _RateBooking extends State<RateBooking> {
  final _loggedInStateInfo = LoginService();
  var userData;

  InteractiveStarsWidget stars = InteractiveStarsWidget(rate: 2.5);
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() {
    var data = _loggedInStateInfo.user_info;
    setState(() {
      userData = data;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rate this Booking'),
          centerTitle: true,
        ),
        body: Container(
            padding: const EdgeInsets.only(top: 0, left: 20),
            child: Column(
                children: <Widget>[
                  ListTile(
                    leading: _getLeadingWidget("", Colors.blue),
                    title: _getTitleWidget(userData["username"]),
                    subtitle: _getCommentWidget(),
                    isThreeLine: true,
                  )
                ]
            )
        )
    );
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

  Widget _getCommentWidget() {
    return Column(
      children: [
        Align(
            alignment: Alignment.topLeft,
            child :Row(
                children:const [
                  Text("Tap the stars and put a comment below"),
                ]
            )
        ),
        const SizedBox(height:20),
        Row(
            children: <Widget>[
              stars
            ]
        ),
        const SizedBox(height:20),
        TextFormField(
          controller : myController,
          decoration: InputDecoration(
            enabled: true,
            contentPadding: const EdgeInsets.all(12.0),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            // Border Label TextBox 1
            labelText: "Enter a message",
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            hintText: "",
            hintMaxLines: 2,
            hintStyle: const TextStyle(
              color: Colors.black,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          keyboardType: TextInputType.multiline,
          minLines: 2,
          maxLines: 4,
        ),
        const SizedBox(height:20),
        GreenButton("Rate it",
            onPressed: (){
              RatingService.addBookingRating(widget.booking_id,widget.publication_id,myController.text, stars.rate, context);
            }
        ),
      ],
    );
  }
}

