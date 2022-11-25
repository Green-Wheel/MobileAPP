import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/backendServices/change_password.dart';


class ChangePassword extends StatefulWidget{
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final password_againController = TextEditingController();

  bool reset_done = false;
  bool? reset_done2;

  void _checkPassword(String password,BuildContext context) async {
     ChangePasswordService.checkPassword(password,context);
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text("Change Password"),
          ),
          body: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                  key: formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Type down two times your password.",
                            textAlign: TextAlign.center,style: TextStyle(fontSize: 22)),
                        Container(
                            color: Colors.white,
                            child: TextFormField(
                              obscureText:true,
                              style: TextStyle(color: Colors.black),
                              controller: passwordController,
                              cursorColor: Colors.black ,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.black),
                                labelText:'Password',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (password) => password != null
                                  ? 'Enter a valid password' : null,
                            )
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height/40,),
                        Container(
                            color: Colors.white,
                            child: TextFormField(
                              obscureText: true,
                              style: TextStyle(color: Colors.black),
                              controller: password_againController,
                              cursorColor: Colors.black ,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.black),
                                labelText:'Repeat Password',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (password) => password != null
                                  ? 'Enter a valid password' : null,
                            )
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height/40,),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50),
                            backgroundColor: Colors.green,
                          ),
                          icon: Icon(Icons.password),
                          label: Text(
                              'Reset Password',
                              style: TextStyle(fontSize: 22)
                          ),
                          onPressed: (){
                            if(!reset_done && passwordController.text == password_againController.text && passwordController.text != ""){
                              _checkPassword(passwordController.text,context);
                            }
                          },
                        ),
                      ]
                  )
              )
          )
      );
}
