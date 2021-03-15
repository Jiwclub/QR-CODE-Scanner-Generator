import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';

class GenerateQrCodePage extends StatefulWidget {
  // const GenerateQrCodePage({Key key}) : super(key: key);

  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;

  GlobalKey globalKey = new GlobalKey();
  String _dataString = "Hello from this QR";
  String _inputErrorText;
  final TextEditingController _textController = TextEditingController();

  @override
  _GenerateQrCodePageState createState() => _GenerateQrCodePageState();
}

class _GenerateQrCodePageState extends State<GenerateQrCodePage> {
  String qrData = "";
  final qrdataFeed = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(
      //   title: Text('สร้าง QR Code'),
      //   centerTitle: true,
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.share),
      //       onPressed: _captureAndSharePng,
      //     )
      //   ],
      // ),
      body: SafeArea(
              child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 100,),
                Center(
                  child: QrImage(
                    size: 200,
                    //plce where the QR Image will be shown
                    data: qrData,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Text(
                  "สร้าง QR Code ใหม่",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                  SizedBox(
                  height: 40.0,
                ),
                TextField(
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  controller: qrdataFeed,
                  decoration: InputDecoration(
                      hintText: "ใส่รหัสที่ต้องการ สร้าง QR Code",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      fillColor: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
                  child: FlatButton(
                    padding: EdgeInsets.all(15.0),
                    onPressed: () async {
                      if (qrdataFeed.text.isEmpty) {
                        //a little validation for the textfield
                        setState(() {
                          qrData = "";
                        });
                      } else {
                        setState(() {
                          qrData = qrdataFeed.text;
                        });
                      }
                    },
                    child: Text(
                      "สร้าง QR",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 3.0),
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          GlobalKey().currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      final channel = const MethodChannel('channel:me.alfian.share/share');
      channel.invokeMethod('shareFile', 'image.png');
    } catch (e) {
      print(e.toString());
    }
  }
}
