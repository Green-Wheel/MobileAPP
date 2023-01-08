import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/services/backend_service.dart';

import '../../../services/generalServices/LoginService.dart';
import 'bottom_text.dart';
import 'top_text.dart';

enum Screens {
  createAccount,
  welcomeBack,
}

class LoginContent extends StatefulWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent>
    with TickerProviderStateMixin {
  late final List<Widget> createAccountContent;
  late final List<Widget> loginContent;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void validateLogin() {
    var username = usernameController.value.text;
    var password = passwordController.value.text;
    var jsonMap = {
      "username": username,
      "password": password,
    };
    BackendService.post('users/login/', jsonMap).then((response) {
      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        var apiKey = jsonResponse["apikey"];
        final _loggedInStateInfo = LoginService();
        _loggedInStateInfo.loginUser(apiKey);
        GoRouter.of(context).push('/');
        print("Login successful");
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: const Text('Wrong password')));
        print(response.body);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: const Text('User not found')));
        print(response.body);
      }
    });
  }

  Future<void> login_raco() async {
    final authSuccess = await LoginService.instance.raco_login();
    if (authSuccess) {
      GoRouter.of(context).push('/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text('Login with raco failed')));
    }
  }

  Future<void> login_google() async {
    final authSuccess = await LoginService.instance.google_login();
    if (authSuccess) {
      GoRouter.of(context).push('/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text('Login with google failed')));
    }
  }

  Widget inputField(String hint, IconData iconData, controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: SizedBox(
        height: 50,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          child: TextField(
            controller: controller,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              prefixIcon: Icon(iconData),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputPasswordField(String hint, IconData iconData, controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: SizedBox(
        height: 50,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          child: TextField(
            controller: controller,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              prefixIcon: Icon(iconData),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 16),
      child: ElevatedButton(
        onPressed: () {
          validateLogin();
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: const StadiumBorder(),
          primary: Color(0xFF265DAB),
          elevation: 8,
          shadowColor: Colors.black87,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget orDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 8),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 1,
              color: Color(0xFF2D5D70),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'or',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 1,
              color: Color(0xFF2D5D70),
            ),
          ),
        ],
      ),
    );
  }

  Widget logos() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                login_raco();
              },
              icon: Image.asset('assets/images/raco.png')),
          const SizedBox(width: 24),
          IconButton(
              onPressed: () {
                login_google();
              },
              icon: Image.asset('assets/images/google.png')),
        ],
      ),
    );
  }

  Widget forgotPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 110),
      child: TextButton(
        onPressed: () {
          GoRouter.of(context).push('/login/recover_password');
        },
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF265DAB),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    /*createAccountContent = [
      inputField('Username', Icons.person_outline),
      inputField('Email', Icons.mail_outline),
      inputField('Password', Icons.lock),
      loginButton('Sign Up'),
      //orDivider(),
      //logos(),
    ]; */

    loginContent = [
      inputField('Username', Icons.person_outline, usernameController),
      inputPasswordField('Password', Icons.lock, passwordController),
      loginButton('Log In'),
      //orDivider(),
      logos(),
      forgotPassword(),
    ];

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          top: 136,
          left: 24,
          child: TopText(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: loginContent,
              ),
            ],
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: BottomText(),
          ),
        ),
      ],
    );
  }
}
