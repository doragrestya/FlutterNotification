import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notifapp/constant/ConstantFile.dart';
import 'package:notifapp/model/ModelNews.dart';

abstract class BaseEndPoint {
  Future<List> getNews(String myId);
  void addNews(String title, String description, File image);
  void sendNotification(String urlImage);
  void deleteNews(String idNews);
}

class NetworkProvider extends BaseEndPoint {
  @override
  Future<List> getNews(String id) async {
    // TODO: implement getNews
    final response = await http
        .post(ConstantFile().baseUrl + "getNews", body: {'iduser': id});
    ModelNews listData = modelNewsFromJson(response.body);

    return listData.article;
  }

  @override
  void addNews(
      String title, String description, File image) async {
    // TODO: implement addNews
    var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();
    var request = http.MultipartRequest(
        'POST', Uri.parse(ConstantFile().baseUrl + 'addNews'));

    var multipart =
    http.MultipartFile('image', stream, length, filename: image.path);
    request.files.add(multipart);
    request.fields['title'] = title;
    request.fields['description'] = description;
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Image Uploaded');
    } else {
      print('Image Failed Uploaded');
    }
  }

  @override
  void sendNotification(String urlImage) async{
    // TODO: implement sendNotification
    final body = jsonEncode({
      "to": "/topics/MentoringTopic",
      "topic": "MentoringTopic",
      "notification": {
        "body": "Kumpulan berita yang sedang hangat dan terpercaya. Lihat sekarang juga!!!",
        "title": "Berita Hari Ini",
        "sound": "default",
        "image": urlImage
      },
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "body": "This is a Firebase Cloud Messaging Topic Message!",
      }
    });
    await http.post("https://fcm.googleapis.com/fcm/send",
        headers: {
          HttpHeaders.authorizationHeader: ConstantFile().keyServer,
          HttpHeaders.contentTypeHeader: "application/json"
        },
        body: body);
  }

  @override
  void deleteNews(String idNews) async{
    // TODO: implement deleteNews
    final response = await http.post(ConstantFile().baseUrl + "deleteNews", body: {
      'idnews' : idNews
    });
    var listData = jsonDecode(response.body);
    if(listData['status'] == 200){
      print(listData['message']);
    } else {
      print(listData['message']);
    }
  }
}
