import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_api/models/character_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  var data = [].obs;
  ScrollController scrollController = ScrollController();
  int offset = 0;
  final ts = '1650928145941';
  final apiKey = 'f6808f90b62dc9fabad55db2491950e0';
  final lastKey = 'ef627239527ed3c1b9c5c704a83bd3aa';

  @override
  void onInit() {
    characters();
    scrollController.addListener(loadMore);
    super.onInit();
  }

  Future characters() async {
    try {
      var url = Uri.parse(
          'http://gateway.marvel.com/v1/public/characters?limit=100&offset=$offset&ts=$ts&apikey=$apiKey&hash=$lastKey');
      var response = await http.get(url);
      var jsonData = json.decode(response.body);
      jsonData = jsonData['data']['results'];
      for (var item in jsonData) {
        data.add(Character.fromJson(item));
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future loadMore() async {
    if (scrollController.position.extentAfter <= 0) {
      offset += 50;
      await characters();
    }
  }

  Future buscarCharacter(charId) async {
    try {
      var url = Uri.parse(
          'http://gateway.marvel.com/v1/public/characters/$charId?ts=$ts&apikey=$apiKey&hash=$lastKey');
      var response = await http.get(url);
      var jsonData = json.decode(response.body);
      jsonData = jsonData['data']['results'];
      jsonData = Character.fromJson(jsonData[0]);
      return jsonData;
    } catch (e) {
      print(e);
    }
  }

  abrirUrl(urls) async {
    final url = Uri.parse(urls[0]['url']);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Failed to launch ${url.toString()}");
    }
  }
}
