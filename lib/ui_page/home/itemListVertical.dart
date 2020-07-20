import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notifapp/constant/ConstantFile.dart';
import 'package:notifapp/model/ModelNews.dart';
import 'package:notifapp/network/NetworkProvider.dart';
import 'package:notifapp/ui_page/home/DetailPage.dart';

class itemListVertical extends StatefulWidget {
  List list;
  itemListVertical({this.list});
  @override
  _itemListVerticalState createState() => _itemListVerticalState();
}

class _itemListVerticalState extends State<itemListVertical> {
  BaseEndPoint network = NetworkProvider();
  var dateFormat;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.list.length,
      itemBuilder: (BuildContext context, int index) {
        Article data = widget.list[index];
        dateFormat = DateFormat("dd-MM-yyyy").format(data.dateNews);
        return Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 2, bottom: 8, top: 10),
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 120,
                      width: 120,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            ConstantFile().imageUrl + data.imageNews,
                            fit: BoxFit.fill,
                          )),
                    ),
                    Flexible(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(title : data.titleNews,
                                deskripsi : data.descriptionNews, image : data.imageNews)));
                              },
                              child: Text(
                                data.titleNews,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                                maxLines: 2,
                              ),
                            ),
                            Text(
                              data.descriptionNews,
                              style: TextStyle(fontSize: 14),
                              softWrap: true,
                              maxLines: 5,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.access_time),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(dateFormat),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "| PNP",
                                        style: TextStyle(color: Colors.red),
                                      )
                                    ],
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.delete_forever,
                                          color: Colors.red),
                                      onPressed: () {
                                        AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.ERROR,
                                            animType: AnimType.BOTTOMSLIDE,
                                            title: 'Warning',
                                            desc:
                                                'Do You Want to delete this item',
                                            btnCancelOnPress: () {},
                                            btnOkOnPress: () async {
                                              network.deleteNews(data.idNews);
                                              setState(() {
                                                widget.list.removeAt(index);
                                              });
                                              await network.getNews("");
                                            }).show();
                                      }),
                                ]),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Divider(
                color: Colors.pink,
                height: 1,
                thickness: 2,
              ),
            ],
          ),
        );
      },
    );
  }
}
