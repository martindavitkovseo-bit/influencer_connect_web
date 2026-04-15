class User {
  final String id;
  final String name;
  final String email;
  final String type; // 'influencer' or 'business'
  final String? bio;
  final String? profileImageUrl;
  final String? category;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
    this.bio,
    this.profileImageUrl,
    this.category,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      type: json['type'] as String,
      bio: json['bio'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      category: json['category'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'type': type,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
