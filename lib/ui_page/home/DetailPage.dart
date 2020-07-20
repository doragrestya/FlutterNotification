import 'package:flutter/material.dart';
import 'package:notifapp/constant/ConstantFile.dart';
import 'package:notifapp/network/NetworkProvider.dart';

class DetailPage extends StatefulWidget {
  String title;
  String deskripsi;
  String image;
  DetailPage({this.title, this.deskripsi, this.image});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  BaseEndPoint network = NetworkProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''), backgroundColor: Colors.red, iconTheme: IconThemeData(color: Colors.red),
      ),

      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  widget.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    child: Image.network(ConstantFile().imageUrl + widget.image,
                      fit: BoxFit.fill,),
                  ),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          widget.deskripsi, style: TextStyle(fontSize: 15), textAlign: TextAlign.justify,
                        ),
                      ),
                    ],

                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
