import 'package:flutter/material.dart';
import 'package:flutterblog/auth.dart';
// ignore: unused_import
import 'package:flutterblog/loginpage.dart';
import 'package:flutterblog/mapping.dart';

// import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      home: MappingPage(auth:Auth(),),
      debugShowCheckedModeBanner: false,
    );
  }
}

