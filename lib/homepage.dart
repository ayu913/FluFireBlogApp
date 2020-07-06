import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutterblog/PhotoUpload.dart';
import 'auth.dart';
import 'package:flutterblog/posts.dart';
import 'package:firebase_database/firebase_database.dart';

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
  List<Posts> postsList = [];

  @override
  void initState() {
    super.initState();
    DatabaseReference postsRef =
        FirebaseDatabase.instance.reference().child("Posts");
    postsRef.once().then((DataSnapshot snap) {
      // ignore: non_constant_identifier_names
      var KEYS = snap.value.keys;
      // ignore: non_constant_identifier_names
      var DATA = snap.value;

      postsList.clear();
      for (var individualKey in KEYS) {
        Posts posts = new Posts(
          DATA[individualKey]['image'],
          DATA[individualKey]['description'],
          DATA[individualKey]['date'],
          DATA[individualKey]['time'],
        );
        postsList.add(posts);
      }
      setState(() {
        print('Length : $postsList.length');
      });
    });
  }

  void _logoutUser() async {
    try {
      await widget.auth.signOut();

      widget.onSignedOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
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
      body: Container(
        child: postsList.length==0?Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical:180.0),
            child: Text("No Blog Post available", style: TextStyle(fontSize: 20),),
          ),
        ):ListView.builder(
          itemCount: postsList.length,
          itemBuilder: (_,index){
            return PostsUI(
              postsList[index].image,
              postsList[index].description,
               postsList[index].date,
                postsList[index].time,

            );
          }
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.lock_open),
                iconSize: 20,
                color: Colors.white,
                onPressed: _logoutUser,
              ),
              IconButton(
                  icon: Icon(Icons.add_a_photo),
                  iconSize: 20,
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhotoUploadPage(),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget PostsUI(String image, String description, String date, String time) {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),
      child: Container(
        padding: EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  date,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
                Text(
                  time,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Image.network(image,fit:BoxFit.cover),
              SizedBox(height: 10.0,),
               Text(
                  description,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.center,
                ),
              

          ],
        ),
      ),
    );
  }
}
