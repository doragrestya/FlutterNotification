import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notifapp/network/NetworkProvider.dart';
import 'package:notifapp/ui_page/add_page/AddPage.dart';
import 'package:notifapp/ui_page/home/home/itemListVertical.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  BaseEndPoint network = NetworkProvider();

  getNotification() {
    _firebaseMessaging.subscribeToTopic('MentoringTopic');
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
      showDialog(context: context,builder: (context){
        return AlertDialog(
          title: Text('${message['notification']['title']}', textAlign: TextAlign.center,),
          content: Text('${message['notification']['body']}'),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('Ok'),
            )
          ],
        );
      });
        }, onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
      final notification = message['notification'];
      print(notification['title']);
    }, onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
      final notification = message['notification'];
      print(notification['title']);
    });
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.note_add,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddPage()));
            },
          ),
        ],
        title: Text('POLITEKNIK NEGERI PADANG'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Card(
                  color: Colors.red,
                  child: Container(
                    height: 250,
                    child: Carousel(
                      autoplay: true,
                      images: [
                        AssetImage('images/adm.jpg'),
                        AssetImage('images/akun.jpg'),
                        AssetImage('images/bi.jpg'),
                        AssetImage('images/elektro.jpg'),
                        AssetImage('images/mesin.jpg'),
                        AssetImage('images/sipil.jpg'),
                        AssetImage('images/ti.jpg'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.pink,
            height: 1,
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 4, right: 4),
                  alignment: Alignment.center,
                  height: 35,
                  width: 35,
                  color: Colors.red,
                  child: Text(
                    'N',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4, right: 4),
                  alignment: Alignment.center,
                  height: 35,
                  width: 35,
                  color: Colors.red,
                  child: Text(
                    'E',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4, right: 4),
                  alignment: Alignment.center,
                  height: 35,
                  width: 35,
                  color: Colors.red,
                  child: Text(
                    'W',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4, right: 4),
                  alignment: Alignment.center,
                  height: 35,
                  width: 35,
                  color: Colors.red,
                  child: Text(
                    'S',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: network.getNews(""),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? itemListVertical(
                      list: snapshot.data,
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ],
      ),
    );
  }
}
