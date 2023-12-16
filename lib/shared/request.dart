import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/change_info_after_signup.dart';
import '../domain/post.dart';

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
    'Authorization': isToken ? 'Bearer $token' : '',
  };
  var request = http.MultipartRequest(
    method,
    Uri.parse('$baseUrl$route'),
  );
  print(infoAfter.toJson());
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

Future<http.StreamedResponse> addPostRequest(
  String route,
  String method, {
  bool isToken = true,
  required PostCreate postCreate,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  String baseUrl = "https://it4788.catan.io.vn";

  var headers = {
    'Authorization': isToken ? 'Bearer $token' : '',
  };

  var request = http.MultipartRequest(
    method,
    Uri.parse('$baseUrl$route'),
  );
  print(postCreate.toJson());

  request.headers.addAll(headers);
  request.fields['described'] = postCreate.described ?? '';
  request.fields['status'] = postCreate.status ?? '';
  request.fields['auto_accept'] = postCreate.autoAccept ?? '';

  if (postCreate.image != null) {
    for (int i = 0; i < postCreate.image!.length; i++) {
      if (postCreate.image!.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          postCreate.image![i].path,
          contentType: MediaType('image', 'jpg'),
        ));
      }
    }
  }

  if (postCreate.video != null) {
    request.files.add(await http.MultipartFile.fromPath(
      'video',
      postCreate.video!.path,
      contentType: MediaType('video', 'mp4'),
    ));
  }

  var response = await request.send();
  return response;
}
