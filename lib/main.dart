import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel_api/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const MaterialColor marvelRed = const MaterialColor(
    0xffec1d24,
    const <int, Color>{
      50: Color.fromARGB(10, 236, 29, 36),
      100: Color.fromARGB(20, 236, 29, 36),
      200: Color.fromARGB(30, 236, 29, 36),
      300: Color.fromARGB(40, 236, 29, 36),
      400: Color.fromARGB(50, 236, 29, 36),
      500: Color.fromARGB(60, 236, 29, 36),
      600: Color.fromARGB(70, 236, 29, 36),
      700: Color.fromARGB(80, 236, 29, 36),
      800: Color.fromARGB(90, 236, 29, 36),
      900: Color.fromARGB(100, 236, 29, 36),
    },
  );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Marvel',
      theme: ThemeData(
        primarySwatch: marvelRed,
        scaffoldBackgroundColor: Color(0xff151515),
        cardColor: Color(0xff202020),
      ),
      home: HomePage(title: 'Marvel Character'),
    );
  }
}
