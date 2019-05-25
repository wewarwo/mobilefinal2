import './friend.dart';
import './home.dart';
import './login.dart';
import './profile.dart';
import './register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Final',
    debugShowCheckedModeBanner: false,
    // Start the app with the "/" named route. In our case, the app will start
    // on the FirstScreen Widget
    initialRoute: '/',
    routes: {
      // When we navigate to the "/" route, build the FirstScreen Widget
      '/': (context) => Login(),
      // When we navigate to the "/second" route, build the SecondScreen Widget
      '/register': (context) => Register(),
      '/home': (context) => Home(),
      '/profile': (context) => Profile(),
      '/friend': (context) => myfriend(),
    },
  ));
}