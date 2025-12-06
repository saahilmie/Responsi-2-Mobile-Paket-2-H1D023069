import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_info.dart';

class Api {
  // ni kalo pake chrome/web
  // static const String baseUrl = 'http://localhost/inventaris-api/public';

  // ni kalo pake emulator
  // static const String baseUrl = 'http://10.0.2.2/inventaris-api/public';

  // ni kalo pake device, tinggal ganti IP sesuai IP laptip
  static const String baseUrl = 'http://10.55.57.82/inventaris-api/public';

  static Future<Map<String, String>> getHeaders() async {
    String? token = await UserInfo.getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<dynamic> post(String endpoint, dynamic data) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await getHeaders();

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(data),
      );
      return json.decode(response.body);
    } catch (e) {
      return {'code': 500, 'status': false, 'data': 'Network error: $e'};
    }
  }

  static Future<dynamic> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await getHeaders();

    try {
      final response = await http.get(url, headers: headers);
      return json.decode(response.body);
    } catch (e) {
      return {'code': 500, 'status': false, 'data': 'Network error: $e'};
    }
  }

  static Future<dynamic> put(String endpoint, dynamic data) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await getHeaders();

    try {
      final response = await http.put(
        url,
        headers: headers,
        body: json.encode(data),
      );
      return json.decode(response.body);
    } catch (e) {
      return {'code': 500, 'status': false, 'data': 'Network error: $e'};
    }
  }

  static Future<dynamic> delete(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await getHeaders();

    try {
      final response = await http.delete(url, headers: headers);
      return json.decode(response.body);
    } catch (e) {
      return {'code': 500, 'status': false, 'data': 'Network error: $e'};
    }
  }
}