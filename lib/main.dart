import 'package:flutter/material.dart';
import 'package:flutterblog/auth.dart';
// ignore: unused_import
import 'package:flutterblog/loginpage.dart';
import 'package:flutterblog/mapping.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

// import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
       data: (brightness) => ThemeData(
     
       fontFamily: 'Poppins',
          primaryColor: Colors.blue,
          brightness: brightness ==  Brightness.light
                ? Brightness.light
                : Brightness.dark,
          scaffoldBackgroundColor:brightness ==Brightness.dark ? Colors.blueGrey[900] : Colors.white
           ),
  
      themedWidgetBuilder: (context,themedata) =>   MaterialApp(
        theme: themedata,
       
      home: MappingPage(auth:Auth(),),
      debugShowCheckedModeBanner: false,
          ),
    );
  }
}

