import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/change_info_after_signup.dart';

Future<http.Response> request(String route, String method,
    {bool isToken = true, dynamic body}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  String baseUrl = "https://it4788.catan.io.vn";

  http.Response response;
  var headers = {
    // 'Content-Type': 'application/json',
    'Authorization': isToken ? 'Bearer $token' : '',
  };
  print(token);
  switch (method) {
    case 'GET':
      response = await http.get(Uri.parse('$baseUrl$route'), headers: headers);
      break;
    case 'POST':
      response = await http.post(Uri.parse('$baseUrl$route'),
          headers: headers, body: body);
      break;
    case 'PUT':
      response = await http.put(Uri.parse('$baseUrl$route'),
          headers: headers, body: body);
      break;
    case 'DELETE':
      response =
          await http.delete(Uri.parse('$baseUrl$route'), headers: headers);
      break;
    default:
      throw Exception('Invalid HTTP method');
  }

  return response;
}

Future<StreamedResponse> multipartRequest(String route, String method,
    {bool isToken = true, required InfoAfter infoAfter}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  String baseUrl = "https://it4788.catan.io.vn";

  var headers = {
    // 'Content-Type': 'application/json',
    'Authorization': isToken ? 'Bearer $token' : '',
  };
  var request = http.MultipartRequest(
    method,
    Uri.parse('$baseUrl$route'),
  );
  request.headers.addAll(headers);
  request.fields['username'] = infoAfter.userName;
  if (infoAfter.avatar != null) {
    request.files.add(await http.MultipartFile.fromPath(
      'avatar',
      infoAfter.avatar!.path,
      contentType: MediaType('image', 'jpg'),
    ));
  }
  var response = await request.send();
  return response;
}
