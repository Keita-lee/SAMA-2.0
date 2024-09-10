import 'package:sama/utils/tokenManager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OracleDbManager {
  Future<Map<String, dynamic>> checkSamaNo(String samaNo) async {
    final TokenManager tokenManager = TokenManager();
    String basicAuth = tokenManager.basicAuth();

    http.Response response = await http.get(
        Uri.parse('https://sama-api.onrender.com/get-client/$samaNo'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return {};
  }

  Future<Map<String, dynamic>> checkOracleDb(String email) async {
    final TokenManager tokenManager = TokenManager();
    String basicAuth = tokenManager.basicAuth();

    http.Response response = await http.get(
        Uri.parse(
            'https://sama-api.onrender.com/get-clients?email_sama=$email'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        List items = data['items'];
        if (items.isNotEmpty) {
          print(items[0]);
          return items[0];
        } else {
          return {};
        }
      } else {
        return {};
      }
    }

    return {};
  }
}
