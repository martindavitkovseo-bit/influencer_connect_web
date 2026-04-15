class CollaborationRequest {
  final String id;
  final String campaignId;
  final String influencerId;
  final String businessId;
  final double proposedBudget;
  final String status; // 'pending', 'accepted', 'rejected', 'completed'
  final String? message;
  final DateTime createdAt;
  final DateTime? respondedAt;

  CollaborationRequest({
    required this.id,
    required this.campaignId,
    required this.influencerId,
    required this.businessId,
    required this.proposedBudget,
    required this.status,
    this.message,
    required this.createdAt,
    this.respondedAt,
  });

  factory CollaborationRequest.fromJson(Map<String, dynamic> json) {
    return CollaborationRequest(
      id: json['id'] as String,
      campaignId: json['campaignId'] as String,
      influencerId: json['influencerId'] as String,
      businessId: json['businessId'] as String,
      proposedBudget: (json['proposedBudget'] as num).toDouble(),
      status: json['status'] as String,
      message: json['message'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      respondedAt: json['respondedAt'] != null ? DateTime.parse(json['respondedAt'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'campaignId': campaignId,
      'influencerId': influencerId,
      'businessId': businessId,
      'proposedBudget': proposedBudget,
      'status': status,
      'message': message,
      'createdAt': createdAt.toIso8601String(),
      'respondedAt': respondedAt?.toIso8601String(),
    };
  }
}
