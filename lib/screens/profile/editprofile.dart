
import 'package:flutter/material.dart';
import 'package:greenwheel/screens/register/signup.dart';
import 'package:greenwheel/screens/register/widgets/greenButton.dart';

import '../../services/backendServices/user_service.dart';
import '../../services/generalServices/LoginService.dart';
import '../../widgets/alert_dialog.dart';
import '../../widgets/forms/profile_edit_image.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  @override
  State<EditProfile> createState() => _EditProfile();

}

class _EditProfile extends State<EditProfile> {
  String image_path ="";
  var emailController;
  var aboutController;
  var firstNameController;
  var lastNameController;

  final _loggedInStateInfo = LoginService();
  var userData;
  @override
  void initState() {
    super.initState();
    _getData();
  }
  void _getData() async {
    var data = _loggedInStateInfo.user_info;
    print(data);
    setState(() {
      userData = data;
      emailController = TextEditingController(text : userData['email']);
      aboutController = TextEditingController(text : userData['about']);
      firstNameController = TextEditingController(text : userData['first_name']);
      lastNameController = TextEditingController(text : userData['last_name']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(title: Text("Edit Profile")),
      body: Container(
        child: Column(
          mainAxisSize : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SelectImageEdit(userData["profile_picture"]),
            Container(
              height: MediaQuery.of(context).size.height*0.7 - Size.fromHeight(kToolbarHeight).height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30,0,30,0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child:  Text("Email",  style: TextStyle(fontSize: 18),)
                    ),
                    userInput(emailController,  TextInputType.name ,context,false),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child:  Text("About",  style: TextStyle(fontSize: 18),)
                    ),
                    userInput(aboutController,  TextInputType.visiblePassword,context,false),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child:  Text("FirstName",  style: TextStyle(fontSize: 18),)
                    ),
                    userInput(firstNameController,  TextInputType.name,context,false),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child:  Text("LastName",  style: TextStyle(fontSize: 18),)
                    ),
                    userInput(lastNameController,  TextInputType.name,context,false),
                    GreenButton('Edit profile',onPressed: (){
                      if(emailController.text != "" || aboutController.text !="" ||
                        firstNameController.text != "" || lastNameController.text != "")
                                UserService.editUser(emailController.text,image_path, aboutController.text,
                                    firstNameController.text, lastNameController.text,context);
                      else Future.delayed(Duration.zero, () => showAlert(context,"Error Message","Fill atleast one field"));
                      }
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget{
  final String image_path;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.image_path,
    required this.onClicked,
  }) : super(key:key);
  @override
  Widget build(BuildContext context){
    return Center(child: buildImage());
  }
  Widget buildImage(){
    return Text("");
  }
}