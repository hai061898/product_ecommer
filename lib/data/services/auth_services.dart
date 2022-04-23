import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:product_ecommer/data/models/response_auth.dart';
import 'package:product_ecommer/data/services/url.dart';
import 'package:product_ecommer/utils/secure_storage.dart';

class AuthServices {
  Future<ResponseAuth> login(
      {required String email, required String password}) async {
    final resp = await http.post(Uri.parse('${URLS.urlApi}/auth/login'),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'passwordd': password});

    return ResponseAuth.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseAuth> renewToken() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${URLS.urlApi}/auth/renew-login'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    return ResponseAuth.fromJson(jsonDecode(resp.body));
  }
}

final authServices = AuthServices();
