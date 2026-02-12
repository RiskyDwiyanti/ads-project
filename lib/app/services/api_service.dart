import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://onseason-laravel.test/api';

  // LOGIN
  static Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/signin'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': email,
        'password': password,
      }),
    );

    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    final data = json.decode(response.body);

    // ❗ CEK success dulu
    if (response.statusCode == 200 && data['success'] == true) {
      final token = data['token'];

      if (token == null || token.toString().isEmpty) {
        throw Exception('Token tidak dikirim oleh server');
      }

      return token.toString();
    } else {
      throw Exception(data['message'] ?? 'Login gagal');
    }
  }

  // PROFILE (PROTECTED)
  static Future<Map<String, dynamic>> getProfile(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/auth/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Unauthorized');
    }
  }
}
