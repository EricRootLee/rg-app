import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rg/models/login_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class APIService {
  static const String url = 'https://campaign.redgiant.co.ke/api/';
  static var _token;

  // get Token
  static getToken() async {
    final _storage = FlutterSecureStorage();
    _token = await _storage.read(key: "token");
  }

  static _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $_token'
  };
  
  static Future<LoginResponseModel> login(LoginRequestModel requestModel) async {

    final response = await http.post(url+'auth', body: requestModel.toJson());

    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
