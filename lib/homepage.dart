import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  void _logoutUser(){


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
                icon: Icon(Icons.wifi),
                iconSize: 20,
                color: Colors.white,
                 onPressed:_logoutUser,),

                   IconButton(
                     icon: Icon(Icons.wifi),
                iconSize: 20,
                color: Colors.black,
                 onPressed: null),

            ],
          ),
        ),
      ),
    );
  }
}