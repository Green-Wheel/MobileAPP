import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';
import 'change_password.dart';

class ForgotPasswordScreen extends StatefulWidget{
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreen createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen>{
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final codeController = TextEditingController();
  bool _show_code = false;
  String? code;
  @override
  void dispose(){
      emailController.dispose();
      super.dispose();
  }

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
  }
  int generateRandomNumber(){
    Random random = new Random();
    return random.nextInt(10);
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
          appBar: AppBar(
           // backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text("Reset Password"),
          ),
        body: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                      key: formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Text("We will send you an email to reset the password",
                                  textAlign: TextAlign.center,style: TextStyle(fontSize: 22)),
                              Container(
                                  color: Colors.white,
                                  child: TextFormField(
                                      style: TextStyle(color: Colors.black),
                                      controller: emailController,
                                      cursorColor: Colors.black ,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        labelStyle: TextStyle(color: Colors.black),
                                        labelText:'Email',
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black),
                                        ),
                                      ),
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (email) => email != null && !EmailValidator.validate(email)
                                          ? 'Enter a valid email' : null,
                                  )
                              ),
                              if(_show_code) ...[
                                SizedBox(height: MediaQuery.of(context).size.height/40),
                                Container(
                                    color: Colors.white,
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.black),
                                      controller: codeController,
                                      cursorColor: Colors.black,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        labelStyle: TextStyle(
                                            color: Colors.black),
                                        labelText: 'Code from Email',
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black),
                                        ),
                                      ),
                                      autovalidateMode: AutovalidateMode
                                          .onUserInteraction,
                                      validator: (code) =>
                                      code != null
                                          ? 'Enter a valid code' : null,
                                    )
                                ),
                              ],
                              SizedBox(height: MediaQuery.of(context).size.height/40,),
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size.fromHeight(50),
                                    backgroundColor: Colors.green,
                                  ),
                                  icon: Icon(Icons.email_outlined),
                                  label: Text(
                                    'Reset Password',
                                    style: TextStyle(fontSize: 22)
                                  ),
                                  onPressed: (){
                                    //Comprobar CODE CORRECTE
                                      if(_show_code == false && EmailValidator.validate(emailController.text)) {
                                        setState(() {
                                          code = generateRandomString(generateRandomNumber());
                                          _show_code = true;
                                        });
                                      }
                                      if(codeController.text == "code") {
                                        GoRouter.of(context).push('/login/recover_password/change_password');
                                      }
                                    },
                              ),
                          ]

                     )
               )
          )
      );
}
