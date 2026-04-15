import 'package:http/http.dart' as http;
import 'dart:convert';

class BusinessService {
  static final BusinessService _instance = BusinessService._internal();

  factory BusinessService() {
    return _instance;
  }

  BusinessService._internal();

  static const String apiUrl = 'http://localhost:3000/api';

  Future<List<Map<String, dynamic>>> getBusinessCampaigns(String businessId) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/businesses/$businessId/campaigns'));
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch campaigns');
      }
      return List<Map<String, dynamic>>.from(jsonDecode(response.body) as List);
    } catch (e) {
      throw Exception('Failed to fetch business campaigns: $e');
    }
  }

  Future<Map<String, dynamic>> getBusinessProfile(String businessId) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/businesses/$businessId'));
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch business profile');
      }
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch business profile: $e');
    }
  }

  Future<void> updateBusinessProfile(String businessId, Map<String, dynamic> data) async {
    try {
      await http.patch(
        Uri.parse('$apiUrl/businesses/$businessId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
    } catch (e) {
      throw Exception('Failed to update business profile: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getBusinessRequests(String businessId) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/businesses/$businessId/requests'));
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch requests');
      }
      return List<Map<String, dynamic>>.from(jsonDecode(response.body) as List);
    } catch (e) {
      throw Exception('Failed to fetch business requests: $e');
    }
  }

  Future<Map<String, dynamic>> getBusinessStats(String businessId) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/businesses/$businessId/stats'));
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch business stats');
      }
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch business stats: $e');
    }
  }
}
