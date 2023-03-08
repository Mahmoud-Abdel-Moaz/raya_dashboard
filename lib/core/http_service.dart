import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class HttpService {
  static late http.Client _client;

  static const Map<String, String> _headers = {
    'Content-Type': 'application/json'
  };

  static ini() {
    _client = http.Client();
  }

  static Future<http.Response> getData(String url) {
    return http.get(Uri.parse(url), headers: _headers);
  }

  static Future<http.Response> postData(String url,Map<String,dynamic> body) {
    return http.post(Uri.parse(url), headers: _headers,body: jsonEncode(body));
  }

  static Future<http.Response> deleteData(String url) {
    return  http.delete( Uri.parse(url));

  }

  static Future<http.Response> updateData(String url,Map<String,dynamic> body) {
    return  http.put( Uri.parse(url), headers: _headers,body: jsonEncode(body));
  }

  static Future<http.StreamedResponse> uploadFile(String url,File file)async{
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    return request.send();
  }


}
