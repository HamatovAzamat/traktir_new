import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class AuthController extends GetxController {
  String token;
  DateTime expireDate;
  String userId;
  bool checkAuth = false;

  void isAuth() {
    if (token != null){
      checkAuth = true;
    } else {
      checkAuth = false;
    }
    update();
  }

  String get getToken {
    if ((token != null) &&
        (expireDate != null) &&
        (expireDate.isAfter(DateTime.now()))) {
      return token;
    } else {
      return null;
    }
  }

  /*bool checkAuth() {
    if ((token != null) &&
        (expireDate != null) &&
        (expireDate.isAfter(DateTime.now()))) {
      return true;
    } else {
      return false;
    }
  }*/

  void _authenticate(String email, String password, String operation) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$operation?key=AIzaSyAp2WGbpcIhqdDPRDIaLoa6pq6e6qlLRpo';
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final decodedResponse = json.decode(response.body);
      if (decodedResponse['error'] != null) {
        throw HttpException(decodedResponse['error']['message']);
      };
      token = decodedResponse['idToken'];
      expireDate = DateTime.now()
          .add(Duration(seconds: int.parse(decodedResponse['expiresIn'])));
      userId = decodedResponse['localId'];
    } catch (e) {
      throw e;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
