import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  final String baseUrl; // API base

  ApiProvider({required this.baseUrl});

  // Método para manejar el GET
  Future<dynamic> get(String path) async {
    final url = Uri.parse('$baseUrl$path');

    try {
      final response = await http.get(url, headers: await _setHeaders());
      return _processResponse(response);
    } catch (e) {
      throw Exception('Error en GET: $e');
    }
  }

  // Método para manejar el POST
  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$path');

    try {
      final response = await http.post(
        url,
        headers: await _setHeaders(),
        body: jsonEncode(body),
      );

      await _storeCookies(response.headers);
      return _processResponse(response);
    } catch (e) {
      throw Exception('Error en POST: $e');
    }
  }

  // Método para manejar el PUT (update)
  Future<dynamic> put(String path, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$path');

    try {
      final response = await http.put(
        url,
        headers: await _setHeaders(),
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception('Error en PUT: $e');
    }
  }

  // Método para manejar el DELETE
  Future<dynamic> delete(String path) async {
    final url = Uri.parse('$baseUrl$path');

    try {
      final response = await http.delete(
        url,
        headers: await _setHeaders(),
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception('Error en DELETE: $e');
    }
  }

  Future<void> _storeCookies(Map<String, String> headers) async {
    if (headers.containsKey('set-cookie')) {
      final cookie = headers['set-cookie'];

      if (cookie != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('cookie', cookie);
      }
    }
  }

  // Método para definir los headers
  Future<Map<String, String>> _setHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final cookie = prefs.getString('cookie');

    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (cookie != null)
        'Cookie': cookie, // Include the stored cookie if available
    };
  }

  // Método para procesar las respuestas HTTP
  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        throw Exception('Error 400: Bad request');
      case 401:
        throw Exception('Error 401: Unauthorized');
      case 403:
        throw Exception('Error 403: Forbidden');
      case 404:
        throw Exception('Error 404: Not found');
      case 500:
        throw Exception('Error 500: Internal server error');
      default:
        throw Exception('Error inesperado: ${response.statusCode}');
    }
  }
}
