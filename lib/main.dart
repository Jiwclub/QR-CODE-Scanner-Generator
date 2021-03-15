import 'package:flutter/material.dart';

import 'package:qrcode/main_screen.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.blueAccent,
      // visualDensity: VisualDensity.adaptivePlatformDensity
    ),
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }
}
