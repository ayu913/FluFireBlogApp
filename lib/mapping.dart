import 'package:flutter/material.dart';
import 'package:flutterblog/auth.dart';
import 'package:flutterblog/loginpage.dart';
import 'package:flutterblog/homepage.dart';


class MappingPage extends StatefulWidget {

  final AuthImplementation auth;

  MappingPage({
    this.auth,
  });

  @override
  _MappingPageState createState() => _MappingPageState();
}

enum AuthStatus
{
  notSignedIn,
  signedIn,
}

class _MappingPageState extends State<MappingPage> {


  AuthStatus authStatus = AuthStatus.notSignedIn;
  @override

  void initState()
  {
    super.initState();
    widget.auth.getCurrentUser().then((firebaseUserId)
    {

      setState(() {
        authStatus= firebaseUserId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    }
    
    
    );
  }
  void _signedIn(){
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut(){
             setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    switch(authStatus)
    {
      case AuthStatus.notSignedIn:
      return LoginPage(
        auth:widget.auth,
        onSignedIn:_signedIn,
      );

      case AuthStatus.signedIn:
      return HomePage(
        auth:widget.auth,
        onSignedOut:_signedOut,
      );
    }
    
  }
}