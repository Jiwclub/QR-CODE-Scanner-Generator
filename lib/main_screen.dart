import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:qrcode/screen/generate_qrcode_page.dart';
import 'package:qrcode/screen/scan_qrcode.dart';
import 'package:qrcode/screen/setting_page.dart';

class MainScreen extends StatefulWidget {
  // const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  int selectedIndex = 1;
  final screen = [GenerateQrCodePage(), ScanQrcodePage(), SettingPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: selectedIndex,
          height: 50.0,
          backgroundColor: Colors.blueAccent,
          items: <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.qr_code, size: 30),
            Icon(Icons.settings, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          // backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: screen[selectedIndex]);
  }
}
