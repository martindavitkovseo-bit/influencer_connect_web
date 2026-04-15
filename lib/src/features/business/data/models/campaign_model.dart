class Campaign {
  final String id;
  final String businessId;
  final String title;
  final String description;
  final double budget;
  final int durationMonths;
  final String status; // 'active', 'completed', 'cancelled'
  final List<String> targetCategories;
  final DateTime createdAt;
  final DateTime? endDate;

  Campaign({
    required this.id,
    required this.businessId,
    required this.title,
    required this.description,
    required this.budget,
    required this.durationMonths,
    required this.status,
    required this.targetCategories,
    required this.createdAt,
    this.endDate,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['id'] as String,
      businessId: json['businessId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      budget: (json['budget'] as num).toDouble(),
      durationMonths: json['durationMonths'] as int,
      status: json['status'] as String,
      targetCategories: List<String>.from(json['targetCategories'] as List),
      createdAt: DateTime.parse(json['createdAt'] as String),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'businessId': businessId,
      'title': title,
      'description': description,
      'budget': budget,
      'durationMonths': durationMonths,
      'status': status,
      'targetCategories': targetCategories,
      'createdAt': createdAt.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
    };
  }
}
