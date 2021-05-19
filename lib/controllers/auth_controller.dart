import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class AuthController extends GetxController {
  String token;
  DateTime expireDate;
  String userId;
  bool checkAuth = false;

  bool isAuth() {
    if (token != null){
      checkAuth = true;
    } else {
      checkAuth = false;
    }
    update();
  }


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
      }
      token = decodedResponse['idToken'];
      expireDate = DateTime.now()
          .add(Duration(seconds: int.parse(decodedResponse['expiresIn'])));
      userId = decodedResponse['localId'];

      final prefs = await SharedPreferences.getInstance();
      final userData = jsonEncode({'token': token, 'userId': userId, 'expiryDate': expireDate.toIso8601String()});
      prefs.setString('userData', userData);
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

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')){
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())){
      return false;
    }

    token = extractedUserData['token'];
    userId = extractedUserData['userId'];
    expireDate = expiryDate;

    checkAuth = true;

    update();
    return true;
  }

  Future<void> logout() async {
    token = null;
    userId = null;
    expireDate = null;
    checkAuth = false;

    final prefs = await SharedPreferences.getInstance();
    final deletedData = json.encode({
      'token': null,
      'userId': null,
      'expiryDate': null
    });
    prefs.setString('userData', deletedData);
    update();
  }

  void autoLogout(){

  }
}
