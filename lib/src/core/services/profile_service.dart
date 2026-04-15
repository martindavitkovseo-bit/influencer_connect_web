import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileService {
  static final ProfileService _instance = ProfileService._internal();

  factory ProfileService() {
    return _instance;
  }

  ProfileService._internal();

  static const String apiUrl = 'http://localhost:3000/api';

  Future<Map<String, dynamic>> getUserProfile(String userId) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/users/$userId'));
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch user profile');
      }
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }

  Future<void> updateUserProfile(String userId, Map<String, dynamic> data) async {
    try {
      await http.patch(
        Uri.parse('$apiUrl/users/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  Future<void> uploadProfileImage(String userId, String imagePath) async {
    try {
      // final fileName = 'profiles/$userId/avatar_${DateTime.now().millisecondsSinceEpoch}.jpg';
      // TODO: Implement file upload via Supabase storage
    } catch (e) {
      throw Exception('Failed to upload profile image: $e');
    }
  }
}
