import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void moveToRegister() {}

  void validateAndSave() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Blog App")),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: createInputs() + createButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> createInputs() {
    return [
      SizedBox(
        height: 10.0,
      ),
      logo(),
      SizedBox(
        height: 20.0,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
      ),
      SizedBox(
        height: 10.0,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Password'),
      ),
      SizedBox(
        height: 20.0,
      ),
    ];
  }

  Widget logo() {
    return Hero(
      tag: null,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 110.0,
      ),
    );
  }

  List<Widget> createButtons() {
    return [
      RaisedButton(
        child: Text("Login", style: TextStyle(fontSize: 20.0)),
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: validateAndSave,
      ),
      FlatButton(
        child: Text("Not have an Account?Create Account?",
            style: TextStyle(fontSize: 20.0)),
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: moveToRegister,
      )
    ];
  }
}
