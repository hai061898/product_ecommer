import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:product_ecommer/data/models/response_default.dart';
import 'package:product_ecommer/data/models/response_user.dart';
import 'package:product_ecommer/data/services/url.dart';
import 'package:product_ecommer/utils/secure_storage.dart';

class UserServices {
  Future<ResponseDefault> addNewUser(
      String username, String email, String password) async {
    final resp = await http.post(Uri.parse('${URLS.urlApi}/user/add-new-user'),
        headers: {'Accept': 'application/json'},
        body: {'username': username, 'email': email, 'passwordd': password});

    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }

  Future<User> getUserById() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${URLS.urlApi}/user/get-user-by-id'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    return ResponseUser.fromJson(jsonDecode(resp.body)).user;
  }

  Future<ResponseDefault> updatePictureProfile(String image) async {
    final token = await secureStorage.readToken();

    var request = http.MultipartRequest(
        'PUT', Uri.parse('${URLS.urlApi}/user/update-picture-profile'))
      ..headers['Accept'] = 'application/json'
      ..headers['xxx-token'] = token!
      ..files.add(await http.MultipartFile.fromPath('image', image));

    final resp = await request.send();
    var data = await http.Response.fromStream(resp);

    return ResponseDefault.fromJson(jsonDecode(data.body));
  }

  Future<ResponseDefault> updateInformationUser(String name, String last,
      String phone, String address, String reference) async {
    final token = await secureStorage.readToken();

    final resp = await http.put(
        Uri.parse('${URLS.urlApi}/user/update-information-user'),
        headers: {
          'Accept': 'application/json',
          'xxx-token': token!
        },
        body: {
          'firstname': name,
          'lastname': last,
          'phone': phone,
          'address': address,
          'reference': reference
        });

    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseDefault> updateStreetAddress(
      String address, String reference) async {
    final token = await secureStorage.readToken();

    final resp = await http.put(
        Uri.parse('${URLS.urlApi}/user/update-street-address'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'address': address, 'reference': reference});
    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }
}

final userServices = UserServices();
