import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  SignupScreen({super.key});

  Widget signUpWith(IconData icon) {
    return Container(
      height: 50,
      width: 115,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          TextButton(onPressed: () {}, child: Text('Sign in')),
        ],
      ),
    );
  }

  Widget userInput(TextEditingController userInput, TextInputType keyboardType) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(color: Colors.blueGrey.shade100,border:Border.all(width:3.0), borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
        child: TextField(
          controller: userInput,
          autocorrect: false,
          enableSuggestions: false,
          autofocus: false,
          decoration: InputDecoration.collapsed(
            hintText: "",
            hintStyle: TextStyle(fontSize: 18, color: Colors.white70, fontStyle: FontStyle.italic),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 510,
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
                    SizedBox(height: 10),
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child:   Text("Register a new account",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          )
                        )
                    ),

                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child:  Text("Username",  style: TextStyle(fontSize: 18),)
                    ),
                    userInput(nameController,  TextInputType.name),

                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child:  Text("Email",  style: TextStyle(fontSize: 18),)
                    ),
                    userInput(emailController, TextInputType.emailAddress),
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child:  Text("Password",  style: TextStyle(fontSize: 18),)
                    ),
                    userInput(passwordController,  TextInputType.visiblePassword),
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
                    Container(
                      height: 55,
                      padding: const EdgeInsets.only(top: 5, left: 70, right: 70),
                      child: ElevatedButton(
                        style: ButtonStyle (
                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.green)
                              )
                            )
                        ),
                        onPressed: () {
                          print(emailController);
                          print(passwordController);
                          Navigator.of(context).pop();
                        },
                        child: Text('Sign up', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),),
                      ),
                    ),
                    SizedBox(height: 14),
                    Divider(thickness: 0, color: Colors.white),
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