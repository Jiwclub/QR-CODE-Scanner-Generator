import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode/model/barcode_model.dart';
import 'package:qrcode/service/NetworkService.dart';
import 'package:charset_converter/charset_converter.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as Io;

class ScanQrcodePage extends StatefulWidget {
  const ScanQrcodePage({Key key}) : super(key: key);

  @override
  _ScanQrcodePageState createState() => _ScanQrcodePageState();
}

class _ScanQrcodePageState extends State<ScanQrcodePage> {
  String qrCodeResult = "รหัสสินค้า";

  BarCodeModel databarcode;

  String nameproduct;

  Uint8List imagetext;
  var file;

  List<int> nameproductencoded;
  String qrData = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("สแกนคิวอาร์โค้ด"),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                databarcode != null
                    ? buildImageInteractionCard(databarcode)
                    : buildImageInteractionCard2()
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code_scanner_sharp),
        backgroundColor: Colors.teal,
        onPressed: () async {
          String codeSanner = await BarcodeScanner.scan(); //barcode scnner
          setState(() {
            _postQrcode(codeSanner);
          });
        },
        // _postQrcode('930083004907');
      ),
    );
  }

  void _postQrcode(String postqrcode) {
    NetworkService().getqrcode(postqrcode).then(
      (value) async {
        try {
          var json = jsonDecode(value);

          var jsonmapping = BarCodeModel.fromJson(json);
          setState(() {
            databarcode = jsonmapping;

            // nameproduct = jsonmapping.categoryName;

            print("data...");
            print(jsonmapping.toJson());
          });
        } on FormatException catch (err) {
          print(err);
        }
      },
    );
  }

  Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  Widget buildImageInteractionCard(BarCodeModel databarcode) => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Stack(
              children: [
                Ink.image(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80',
                  ),
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  left: 16,
                  child: Text(
                    '${databarcode.categoryName}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16).copyWith(bottom: 0),
              child: databarcode != null
                  ? Text(
                      '${databarcode.name}',
                      style: TextStyle(fontSize: 16),
                    )
                  : Text('...'),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      ' ราคา ${databarcode.priceAverage}',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
  Widget buildImageInteractionCard2() => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            // databarcode != null ? imageFromBase64String(databarcode.image):Text('...'),
            Stack(
              children: [
                //  imageFromPreferences,
                //  getImagenBase64(imagestring),
                // imagetext != null ? Image.memory(file) : Text('...'),
                Ink.image(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80',
                  ),
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  left: 16,
                  child: Text(
                    '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16).copyWith(bottom: 0),
              child: databarcode != null
                  ? Text(
                      '',
                      style: TextStyle(fontSize: 16),
                    )
                  : Text(''),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      ' ราคา ',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );

  Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
