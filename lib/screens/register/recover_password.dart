import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';
import '../../services/backendServices/recover_password.dart';

class ForgotPasswordScreen extends StatefulWidget{
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreen createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen>{
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final codeController = TextEditingController();

  bool? _show_code = false;
  bool _show_code2 = false;
  bool? good_code;
  bool good_code2 = false;
  String? code;

  void _getRequest(String username) {
    RecoverPasswordService.getRecover(username,context).then((value) {
      setState(()  {
        _show_code = value;
      });
    });
    setState(() {
      _show_code2 = true;
    });
  }

  void _getCode(String code,String username,BuildContext context) async {
    RecoverPasswordService.checkCode(code,username,context);
  }

  @override
  void dispose(){
      nameController.dispose();
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
                              if(!_show_code2) ...[
                                const Text("We will send you an email to reset the password",
                                    textAlign: TextAlign.center,style: TextStyle(fontSize: 22)),
                                Container(
                                    color: Colors.white,
                                    child: TextFormField(
                                        style: TextStyle(color: Colors.black),
                                        controller: nameController,
                                        cursorColor: Colors.black ,
                                        textInputAction: TextInputAction.done,
                                        decoration: const InputDecoration(
                                          labelStyle: TextStyle(color: Colors.black),
                                          labelText:'Username',
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black),
                                          ),
                                        ),
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (userna) => userna != null && userna.isEmpty
                                            ? 'Enter a username' : null,
                                    )
                                ),
                              ]
                              else ...[
                                const Text("Check your email and put the code below",
                                    textAlign: TextAlign.center,style: TextStyle(fontSize: 22)),
                              ],
                              if(_show_code2 && _show_code == false) ...[
                                SizedBox(height: MediaQuery.of(context).size.height/40),
                                Container(
                                    color: Colors.white,
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.black),
                                      controller: codeController,
                                      cursorColor: Colors.black,
                                      textInputAction: TextInputAction.done,
                                      decoration: const InputDecoration(
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
                              ]else if(_show_code2 && _show_code == true) ...[
                                SizedBox(height: MediaQuery.of(context).size.height/40),
                                Container(
                                  color: Colors.white,
                                  child: const CircularProgressIndicator(
                                    color: Colors.black,
                                  )
                                )
                              ],
                              SizedBox(height: MediaQuery.of(context).size.height/40,),
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size.fromHeight(50),
                                    backgroundColor: Colors.green,
                                  ),
                                  icon: const Icon(Icons.email_outlined),
                                  label: const Text(
                                    'Reset Password',
                                    style: TextStyle(fontSize: 22)
                                  ),
                                  onPressed: (){
                                    //Comprobar CODE CORRECTE
                                      if(_show_code == false && nameController.text != "") {
                                        _getRequest(nameController.text);
                                      }
                                      if(_show_code == true && (codeController.text != "")) {
                                        _getCode(codeController.text,nameController.text,context);

                                      }
                                    },
                              ),
                          ]

                     )
               )
          )
      );
}


