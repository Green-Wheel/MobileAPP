import 'package:flutter/material.dart';
import 'package:greenwheel/screens/register/signup.dart';
import 'package:greenwheel/screens/register/widgets/greenButton.dart';

import '../../services/backendServices/user_service.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfile();

}

class _EditProfile extends State<EditProfile> {
  String image_path ="";
  final nameController = TextEditingController();
  final aboutController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

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
            //ProfileWidget();/*
           // ClipOval(child:Material(color:Colors.transparent, child: Ink.image(
            //      image: user?.profile_picture ?? 'assets/images/default_user_img.jpg',
              //    fit: BoxFit.cover,
                //  width:MediaQuery.of(context).size.width/8,
                 // height: MediaQuery.of(context).size.height/8,
                  //child: InkWell(onTap: onClicked),
               //)
             //)
           //);
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
                        child:  Text("Username",  style: TextStyle(fontSize: 18),)
                    ),
                    userInput(nameController,  TextInputType.name ,context,false),
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
                      print(nameController.text);
                      UserService.editUser(nameController.text,image_path
                          , aboutController.text, firstNameController.text,
                          lastNameController.text);
                      //Navigator.pop(context);
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