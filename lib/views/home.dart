import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_api/controllers/home_controller.dart';
import 'package:marvel_api/models/character_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  bool openDialog = false;
  final ct = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(
              () => ct.data.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        controller: ct.scrollController,
                        itemCount: ct.data.length,
                        itemBuilder: (BuildContext context, index) =>
                            GestureDetector(
                          onTap: () => !openDialog
                              ? _showDialog(ct.data[index], context)
                              : null,
                          child: Card(
                            key: Key(ct.data[index].id.toString()),
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ClipRRect(
                                    child: Image.network(
                                      '${ct.data[index].thumbnail['path']}/portrait_medium.${ct.data[index].thumbnail['extension']}',
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: screenWidth / 1.7,
                                        child: Text(
                                          ct.data[index].name,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xfffefefe)),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: SizedBox(
                                          width: screenWidth / 1.7,
                                          child: Text(
                                            ct.data[index].description,
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Color(0xfffefefe),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(data, context) async {
    print(ct.scrollController.position.extentAfter);
    openDialog = true;
    final char = await ct.buscarCharacter(data.id);
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: Color.fromARGB(255, 13, 13, 13),
            width: 3,
          ),
        ),
        backgroundColor: Color(0xff202020),
        elevation: 20,
        title: Text(
          char.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xfff0f0f0),
          ),
        ),
        content: Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              child: Image.network(
                '${char.thumbnail['path']}/portrait_xlarge.${char.thumbnail['extension']}',
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            SizedBox(height: 20.0),
            Text(
              char.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xfff0f0f0),
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ct.abrirUrl(char.urls);
                },
                icon: Icon(Icons.link_rounded),
                label: Text('Acessar pagina completa'),
              ),
            ),
          ],
        ),
      ),
    );
    openDialog = false;
  }
}
