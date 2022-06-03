import 'package:eventmanagementapp/Forgotpassword.dart';
import 'package:eventmanagementapp/Login.dart';
import 'package:eventmanagementapp/Myregister.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': (context) => MyLogin(),
      'Register': (context) => Myregister(),
      'Forgotpassword': (context) => Forgotpassword(),
    },
  ));
}
