import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/screens/register/widgets/greenButton.dart';
import 'package:greenwheel/services/backendServices/user_service.dart';

class SignupScreen extends StatelessWidget {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  SignupScreen({super.key});

  Widget userInput(TextEditingController userInput, TextInputType keyboardType, BuildContext context,bool hide) {
    //return Expanded(
      //child: Row(
        //children: [
          return Container(
          height: MediaQuery.of(context).size.height/16,
          margin: EdgeInsets.only(bottom: 0),
          decoration: BoxDecoration(color: Colors.white,border:Border.all(width:3.0), borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Padding(
            padding: EdgeInsets.only(left: 25.0, top: 0, right: 25),
            child: TextField(
              obscureText: hide,
              controller: userInput,
              autocorrect: false,
              enableSuggestions: false,
              autofocus: false,
              decoration: InputDecoration.collapsed(
                hintText: "",
                hintStyle: TextStyle(fontSize: 27, color: Colors.white70, fontStyle: FontStyle.italic),
              ),
              keyboardType: keyboardType,
            ),
          ),
      //  )]
      //)
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(title: Text("Register")),
      body: Container(
        child: Column(

          mainAxisSize : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.9 - Size.fromHeight(kToolbarHeight).height,
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
                        child:   Text("Register a new account",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child:  Text("Username",  style: TextStyle(fontSize: 18),)
                    ),
                    userInput(nameController,  TextInputType.name ,context,false),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child:  Text("Email",  style: TextStyle(fontSize: 18),)
                    ),
                    userInput(emailController, TextInputType.emailAddress,context,false),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child:  Text("Password",  style: TextStyle(fontSize: 18),)
                    ),
                    userInput(passwordController,  TextInputType.visiblePassword,context,true),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child:  Text("FirstName",  style: TextStyle(fontSize: 18),)
                    ),
                    userInput(firstNameController,  TextInputType.visiblePassword,context,false),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child:  Text("LastName",  style: TextStyle(fontSize: 18),)
                    ),
                    userInput(lastNameController,  TextInputType.visiblePassword,context,false),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Have already an account? ', style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Log In',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    GreenButton('Sign Up',onPressed: (){
                      UserService.registerUser(nameController.text,emailController.text
                          , passwordController.text, firstNameController.text,
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