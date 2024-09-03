import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TokenStorage {
  static const String _tokenKey = 'jwt_token';
  static const String _expiresInKey = 'jwt_expires_in';
  // Save the token to shared preferences
  Future<void> saveToken(String token, int expiresIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setInt(_expiresInKey, expiresIn);
  }

  // Retrieve the token from shared preferences
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Remove the token (optional, if you need to log out or invalidate the token)
  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}

class TokenManager {
  final TokenStorage _storage = TokenStorage();

  Future<bool> isTokenExpired() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? expireTime = prefs.getInt('jwt_expires_in');

    try {
      if (expireTime == null) {
        return true; // No expiration time found, consider expired
      }

      // Check if the current time is past the expiration time
      int currentTimeInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      return currentTimeInSeconds > expireTime;
    } catch (e) {
      // If decoding fails, consider the token as expired
      return true;
    }
  }

  // method to refresh the token if it's expired
  Future<void> refreshTokenIfNeeded() async {
    if (await isTokenExpired()) {
      // Your logic to get a new token
      Map<String, dynamic> newToken = await _getNewToken();
      if (newToken.isNotEmpty) {
        await _storage.saveToken(newToken['token'], newToken['expiration']);
      }
    }
  }

  // method to get a new token
  Future<Map<String, dynamic>> _getNewToken() async {
    final username = 'v2rCd_QjCe6eSp6LaSoWpA..';
    final password = '9T2_yxuf7cT3a5YpvABC0Q..';

    final credentials = '$username:$password';

    // Encode credentials to base64
    String basicAuth = 'Basic ${base64.encode(utf8.encode(credentials))}';
    print(basicAuth);
    try {
      // fetch a new token from the API
      var response = await http.post(
        Uri.parse('https://sama-api.onrender.com/get-token'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': basicAuth,
        },
      );

      if (response.statusCode == 200) {
        // Successfully authenticated
        Map<String, dynamic> responseData = json.decode(response.body);
        String accessToken = responseData['access_token'];
        int expiresIn = responseData['expires_in'];

        // Calculate the expiration time
        int currentTimeInSeconds =
            DateTime.now().millisecondsSinceEpoch ~/ 1000;
        int expirationTime = currentTimeInSeconds + expiresIn;

        print('Access Token: $accessToken');

        return {"token": accessToken, "expiration": expirationTime};
        // Proceed with using the access token
      } else {
        // Handle errors
        print('Failed to authenticate: ${response.statusCode}');
        print('Response body: ${response.body}');
        return {};
      }
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  String basicAuth() {
    final username = 'v2rCd_QjCe6eSp6LaSoWpA..';
    final password = '9T2_yxuf7cT3a5YpvABC0Q..';

    final credentials = '$username:$password';

    return 'Basic ${base64.encode(utf8.encode(credentials))}';
  }
}
