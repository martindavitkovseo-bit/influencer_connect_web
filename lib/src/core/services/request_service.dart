import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestService {
  static final RequestService _instance = RequestService._internal();

  factory RequestService() {
    return _instance;
  }

  RequestService._internal();

  static const String apiUrl = 'http://localhost:3000/api';

  Future<List<Map<String, dynamic>>> getRequests({String? userId}) async {
    try {
      final uri = userId != null
          ? Uri.parse('$apiUrl/requests?userId=$userId')
          : Uri.parse('$apiUrl/requests');
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch requests');
      }
      return List<Map<String, dynamic>>.from(jsonDecode(response.body) as List);
    } catch (e) {
      throw Exception('Failed to fetch requests: $e');
    }
  }

  Future<Map<String, dynamic>> createRequest({
    required String campaignId,
    required String influencerId,
    required String businessId,
    required double proposedBudget,
    String? message,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/requests'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'campaign_id': campaignId,
          'influencer_id': influencerId,
          'business_id': businessId,
          'proposed_budget': proposedBudget,
          'status': 'pending',
          'message': message,
        }),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to create request');
      }
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to create request: $e');
    }
  }

  Future<void> updateRequestStatus(String requestId, String status) async {
    try {
      await http.patch(
        Uri.parse('$apiUrl/requests/$requestId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'status': status}),
      );
    } catch (e) {
      throw Exception('Failed to update request: $e');
    }
  }

  Future<void> deleteRequest(String requestId) async {
    try {
      await http.delete(Uri.parse('$apiUrl/requests/$requestId'));
    } catch (e) {
      throw Exception('Failed to delete request: $e');
    }
  }
}
