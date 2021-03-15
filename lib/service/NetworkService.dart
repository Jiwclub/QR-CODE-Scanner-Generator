// import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkService {
  Future<String> getqrcode(String qrcode) async {
    print('BarCodeModel' + qrcode);
    var response;
    String  data;
    try {
      var url = Uri.http(
          'staging-barcode.9phum.com', 'api/v1/search-barcode/$qrcode');
      response = await http.get(url);
     data = utf8.decode(response.bodyBytes);
      print(response.toString());
    } on Exception catch (exception) {
      print('Exception GetReportHistory: ${exception.toString()}');
      return exception.toString();
    } catch (error) {
      print('Exception error: ${error.toString()}');

      return error.toString();
    }
    return data;
  }
}
