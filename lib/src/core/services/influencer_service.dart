import 'package:http/http.dart' as http;
import 'dart:convert';

class InfluencerService {
  static final InfluencerService _instance = InfluencerService._internal();

  factory InfluencerService() {
    return _instance;
  }

  InfluencerService._internal();

  static const String apiUrl = 'http://localhost:3000/api';

  Future<List<Map<String, dynamic>>> searchInfluencers({
    String? category,
    String? searchTerm,
    int limit = 50,
  }) async {
    try {
      final params = <String, String>{
        'type': 'influencer',
        'limit': limit.toString(),
      };
      if (category != null && category.isNotEmpty) {
        params['category'] = category;
      }
      if (searchTerm != null && searchTerm.isNotEmpty) {
        params['search'] = searchTerm;
      }

      final uri = Uri.parse('$apiUrl/influencers').replace(queryParameters: params);
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception('Failed to search influencers');
      }
      return List<Map<String, dynamic>>.from(jsonDecode(response.body) as List);
    } catch (e) {
      throw Exception('Failed to search influencers: $e');
    }
  }

  Future<Map<String, dynamic>> getInfluencerProfile(String influencerId) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/influencers/$influencerId'));
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch influencer profile');
      }
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch influencer profile: $e');
    }
  }

  Future<void> updateInfluencerProfile(String influencerId, Map<String, dynamic> data) async {
    try {
      await http.patch(
        Uri.parse('$apiUrl/influencers/$influencerId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
    } catch (e) {
      throw Exception('Failed to update influencer profile: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getInfluencerStats(String influencerId) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/influencers/$influencerId/stats'));
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch influencer stats');
      }
      return List<Map<String, dynamic>>.from(jsonDecode(response.body) as List);
    } catch (e) {
      throw Exception('Failed to fetch influencer stats: $e');
    }
  }
}
