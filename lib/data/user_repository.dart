import 'dart:convert';
import 'dart:io';

import 'package:flutter_application/shared/request.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserRepository {
  Future<dynamic> getUserInfo(String userId);
  Future<dynamic> updateUserInfo(
      String username,
      String description,
      File avatar,
      String address,
      String city,
      String country,
      File cover,
      String link);
}

class UserRepositoryImpl implements UserRepository {
  @override
  Future<dynamic> getUserInfo(String userId) async {
    final http.Response response = await request('/get_user_info', 'POST',
        isToken: true, body: {"user_id": userId});
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  @override
  Future<dynamic> updateUserInfo(
      String username,
      String description,
      File avatar,
      String address,
      String city,
      String country,
      File cover,
      String link) async {
    dynamic body = {
      "username": username,
      "description": description,
      "avatar": avatar,
      "address": address,
      "city": city,
      "country": country,
      "cover": cover,
      "link": "khanh",
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://it4788.catan.io.vn/set_user_info'));
    request.headers['Authorization'] = 'Bearer $token';

    if (username != null)
      request.fields['username'] = username;
    else
      request.fields['username'] = "Mai Van Khanh";

    if (description != null)
      request.fields['description'] = description;
    else
      request.fields['description'] = "";

    if (address != null)
      request.fields['address'] = address;
    else
      request.fields['address'] = "";

    if (city != null)
      request.fields['city'] = city;
    else
      request.fields['city'] = "";

    if (country != null)
      request.fields['country'] = country;
    else
      request.fields['country'] = "";

    if (link != null)
      request.fields['link'] = link;
    else
      request.fields['link'] = "";

    print("avatar path = " + avatar.path);
    request.files.add(await http.MultipartFile.fromPath('avatar', avatar.path,
        contentType: MediaType("image", getExtensionFromUrl(avatar.path))));

    print("cover path = " + cover.path);
    request.files.add(await http.MultipartFile.fromPath(
        'cover_image', cover.path,
        contentType: MediaType("image", getExtensionFromUrl(cover.path))));

    // Gửi request và nhận response
    var response = await request.send();
    var resdata = await http.Response.fromStream(response);
    Map<String, dynamic> data = json.decode(resdata.body);
    print(" Code = " + data['code']);
    print(" Message = " + data['message']);

    if (response.statusCode == 200) {
      // Xử lý dữ liệu nhận được
      var responseData = await response.stream.bytesToString();
      return responseData;
    } else {
      //var responseData = await response.stream.bytesToString();

      //throw Exception('Failed to update user info');
    }
  }

  String getExtensionFromUrl(String url) {
    int index = url.lastIndexOf('.');
    return index != -1 ? url.substring(index + 1) : '';
  }
}
