import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutterblog/auth.dart';
import 'package:flutterblog/dialogbox.dart';

class LoginPage extends StatefulWidget {

  LoginPage({
    this.auth,
    this.onSignedIn,
  });
   final AuthImplementation auth;
   final VoidCallback onSignedIn;


  @override
  _LoginPageState createState() => _LoginPageState();


}

enum FormType{

  login,register
}

class _LoginPageState extends State<LoginPage> {

  DialogBox dialogBox = new DialogBox();
  final formKey = GlobalKey<FormState>();
  FormType _formType = FormType.login;
  // ignore: unused_field
  String _email = "";
  // ignore: unused_field
  String _password = "";
  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType=FormType.register;
    });
  }

void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType=FormType.login;
    });
  }
  bool validateAndSave() {

    final form = formKey.currentState;

    if(form.validate())
    {
      form.save();
      return true;
    }
    else
    {
      return false;
    }
    
  }

  void validateAndSubmit() async{
    if(validateAndSave())
    {
       try{
         if(_formType==FormType.login)
         {
           String userId = await widget.auth.signIn(_email,_password);
          //  dialogBox.information(context, "Congratulations", "your are logged in  sucessfully.");
           print("login userId = " + userId);
         }
         else
         {
             String userId = await widget.auth.signUp(_email,_password);
              // dialogBox.information(context, "Congratulations", "your account has been created sucessfully.");
           print("Register userId = " + userId);
         }
      
        widget.onSignedIn();
       }
       catch(e)
       {
         dialogBox.information(context, "Error =", e.toString());
         print("Error =" + e.toString());
       }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Blog App"),
      centerTitle: true,
       actions: <Widget>[
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.light
                  ? Icons.lightbulb_outline
                  : Icons.highlight,
              color: Colors.white,
            ),
            onPressed: () {
              DynamicTheme.of(context).setBrightness(
                  Theme.of(context).brightness == Brightness.light
                      ? Brightness.dark
                      : Brightness.light);
            },
          )
        ],
      
      ),
      body: SingleChildScrollView(
              child: Container(
          margin: EdgeInsets.all(15.0),
          child: Form(

            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: createInputs() + createButtons(),
            ),
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
      
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Email",
              border:
    
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                  validator:(value)
                  {
                     return value.isEmpty?'Email is required.' : null;
                  },
                  onSaved:(value)
                  {
                    return _email = value;
                  }
        ),
      SizedBox(
        height: 15.0,
      ),
      TextFormField(
          obscureText: true,
         
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Password",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                   validator:(value)
                  {
                     return value.isEmpty?'Password is required.' : null;
                  },
                  onSaved:(value)
                  {
                    return _password = value;
                  }
        ),
        
         
      SizedBox(
        height: 20.0,
      ),
    ];
  }

  Widget logo() {
    return Hero(
      tag: "logo",
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 110.0,
        child:Image.asset("assets/logo.png"),
      ),
    );
  }

  // ignore: missing_return
  List<Widget> createButtons() {

    if(_formType == FormType.login)
    {
       return [
     Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.blue,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: validateAndSubmit,
            child: Text("Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold,
                    fontSize: 15,)),
          ),
     ),
     SizedBox(height: 15,),
      MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: moveToRegister ,
        child: Text("Don't have an account? Sign Up",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold,
                fontSize: 15,)),
      ),
      
     
    ];
    }
    else{
      return [
     Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.blue,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: validateAndSubmit,
            child: Text("Create Account",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold,
                    fontSize: 15,)),
          ),
     ),
     SizedBox(height: 15,),
      MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: moveToLogin ,
        child: Text("Already have an account? Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold,
                fontSize: 15,)),
      ),
      
     
    ];

    }
  }
}
