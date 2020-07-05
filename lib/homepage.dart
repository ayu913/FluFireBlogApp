
import 'package:flutter/material.dart';
import 'package:flutterblog/PhotoUpload.dart';
import 'auth.dart';

class HomePage extends StatefulWidget {
   HomePage({
    this.auth,
    this.onSignedOut,
  });
       final AuthImplementation auth;
   final VoidCallback onSignedOut;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  void _logoutUser() async{

    try{
   await widget.auth.signOut();
  
   widget.onSignedOut();
    }
    catch(e)
    {
print(e.toString());
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
      title: Text("abc"),
      ),
      body: Container(
       
      ),
      bottomNavigationBar: BottomAppBar(
        color:Colors.blue,
        child:Container(
           margin: EdgeInsets.only(left:20,right:20),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.lock_open),
                iconSize: 20,
                color: Colors.white,
                 onPressed:_logoutUser,),

                   IconButton(
                     icon: Icon(Icons.add_a_photo),
                iconSize: 20,
                color: Colors.black,
                 onPressed: (){

                   Navigator.push(context, MaterialPageRoute(builder: (context)=>PhotoUploadPage(),),);
                 }),

            ],
          ),
        ),
      ),
    );
  }
}