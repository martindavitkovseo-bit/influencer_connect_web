import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  // Mock API base URL - replace with your actual backend
  static const String apiUrl = 'http://localhost:3000/api';

  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
    required String userType,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'name': name,
          'type': userType,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Registration failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Login failed: ${response.body}');
      }

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> logoutUser() async {
    try {
      // Clear local session
      // TODO: Call logout endpoint if needed
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      // TODO: Get from local storage or API
      return null;
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }

  bool get isAuthenticated {
    // TODO: Check if token exists in storage
    return false;
  }
}
