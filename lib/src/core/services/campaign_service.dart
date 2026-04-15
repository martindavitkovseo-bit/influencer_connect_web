import 'package:http/http.dart' as http;
import 'dart:convert';

class CampaignService {
  static final CampaignService _instance = CampaignService._internal();

  factory CampaignService() {
    return _instance;
  }

  CampaignService._internal();

  static const String apiUrl = 'http://localhost:3000/api';

  Future<List<Map<String, dynamic>>> getCampaigns() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/campaigns'));
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch campaigns');
      }
      return List<Map<String, dynamic>>.from(jsonDecode(response.body) as List);
    } catch (e) {
      throw Exception('Failed to fetch campaigns: $e');
    }
  }

  Future<Map<String, dynamic>> createCampaign({
    required String businessId,
    required String title,
    required String description,
    required double budget,
    required int durationMonths,
    required List<String> targetCategories,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/campaigns'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'business_id': businessId,
          'title': title,
          'description': description,
          'budget': budget,
          'duration_months': durationMonths,
          'target_categories': targetCategories,
          'status': 'active',
        }),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to create campaign');
      }
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to create campaign: $e');
    }
  }

  Future<void> updateCampaignStatus(String campaignId, String status) async {
    try {
      await http.patch(
        Uri.parse('$apiUrl/campaigns/$campaignId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'status': status}),
      );
    } catch (e) {
      throw Exception('Failed to update campaign: $e');
    }
  }

  Future<void> deleteCampaign(String campaignId) async {
    try {
      await http.delete(Uri.parse('$apiUrl/campaigns/$campaignId'));
    } catch (e) {
      throw Exception('Failed to delete campaign: $e');
    }
  }
}
