import 'dart:convert';

import 'package:chat_app/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class ApiHelper
{
  ApiHelper._();
  static ApiHelper apiHelper = ApiHelper._();

  final api = "https://api.imgur.com/3/image";

  Future<String?> uploadImage(Uint8List image)
  async {
    Uri url = Uri.parse(api);
    final header = {
      'Authorization' : 'Client-Id $clientId'
    };
    final body = base64Encode(image);
    http.Response response = await http.post(url,headers:header ,body: body);
    if(response.statusCode==200)
      {
        final data = response.body;
        final json = jsonDecode(data);
       final link =  json['data']['link'];
       return link;
      }
    return null;
  }
}