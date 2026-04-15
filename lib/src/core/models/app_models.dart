/// User model representing app users (business, influencer, admin)
class User {
  final String id;
  final String email;
  final String fullName;
  final String phone;
  final String role; // 'business', 'influencer', 'admin'
  final String status; // 'active', 'suspended', 'deleted'
  final DateTime createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.role,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String,
      phone: json['phone'] as String? ?? '',
      role: json['role'] as String,
      status: json['status'] as String? ?? 'active',
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'phone': phone,
      'role': role,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

/// Business profile model
class BusinessProfile {
  final String id;
  final String userId;
  final String companyName;
  final String website;
  final String industry;
  final String location;
  final String description;
  final String logoUrl;
  final DateTime createdAt;

  BusinessProfile({
    required this.id,
    required this.userId,
    required this.companyName,
    required this.website,
    required this.industry,
    required this.location,
    required this.description,
    required this.logoUrl,
    required this.createdAt,
  });

  factory BusinessProfile.fromJson(Map<String, dynamic> json) {
    return BusinessProfile(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      companyName: json['company_name'] as String,
      website: json['website'] as String? ?? '',
      industry: json['industry'] as String,
      location: json['location'] as String,
      description: json['description'] as String? ?? '',
      logoUrl: json['logo_url'] as String? ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'company_name': companyName,
      'website': website,
      'industry': industry,
      'location': location,
      'description': description,
      'logo_url': logoUrl,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

/// Influencer profile model
class InfluencerProfile {
  final String id;
  final String userId;
  final String displayName;
  final String username;
  final String bio;
  final String niche;
  final String country;
  final String city;
  final String languages;
  final String profileImageUrl;
  final String verificationStatus; // 'unverified', 'verified', 'rejected'
  final bool openToCollab;
  final String contactEmail;
  final String contactPhone;
  final bool shareContactOnAccept;
  final DateTime createdAt;

  InfluencerProfile({
    required this.id,
    required this.userId,
    required this.displayName,
    required this.username,
    required this.bio,
    required this.niche,
    required this.country,
    required this.city,
    required this.languages,
    required this.profileImageUrl,
    required this.verificationStatus,
    required this.openToCollab,
    required this.contactEmail,
    required this.contactPhone,
    required this.shareContactOnAccept,
    required this.createdAt,
  });

  factory InfluencerProfile.fromJson(Map<String, dynamic> json) {
    return InfluencerProfile(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      displayName: json['display_name'] as String,
      username: json['username'] as String,
      bio: json['bio'] as String? ?? '',
      niche: json['niche'] as String,
      country: json['country'] as String,
      city: json['city'] as String? ?? '',
      languages: json['languages'] as String? ?? '',
      profileImageUrl: json['profile_image_url'] as String? ?? '',
      verificationStatus: json['verification_status'] as String? ?? 'unverified',
      openToCollab: json['open_to_collab'] as bool? ?? true,
      contactEmail: json['contact_email'] as String? ?? '',
      contactPhone: json['contact_phone'] as String? ?? '',
      shareContactOnAccept: json['share_contact_on_accept'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'display_name': displayName,
      'username': username,
      'bio': bio,
      'niche': niche,
      'country': country,
      'city': city,
      'languages': languages,
      'profile_image_url': profileImageUrl,
      'verification_status': verificationStatus,
      'open_to_collab': openToCollab,
      'contact_email': contactEmail,
      'contact_phone': contactPhone,
      'share_contact_on_accept': shareContactOnAccept,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

/// Social account model for tracking influencer social media connections
class SocialAccount {
  final String id;
  final String influencerId;
  final String platform; // 'instagram', 'tiktok'
  final String handle;
  final String platformUserId;
  final String accountType;
  final bool isVerifiedConnection;
  final String connectionStatus;
  final DateTime? lastSyncedAt;
  final DateTime createdAt;

  SocialAccount({
    required this.id,
    required this.influencerId,
    required this.platform,
    required this.handle,
    required this.platformUserId,
    required this.accountType,
    required this.isVerifiedConnection,
    required this.connectionStatus,
    this.lastSyncedAt,
    required this.createdAt,
  });

  factory SocialAccount.fromJson(Map<String, dynamic> json) {
    return SocialAccount(
      id: json['id'] as String,
      influencerId: json['influencer_id'] as String,
      platform: json['platform'] as String,
      handle: json['handle'] as String,
      platformUserId: json['platform_user_id'] as String,
      accountType: json['account_type'] as String? ?? '',
      isVerifiedConnection: json['is_verified_connection'] as bool? ?? false,
      connectionStatus: json['connection_status'] as String? ?? 'connected',
      lastSyncedAt: json['last_synced_at'] != null
          ? DateTime.parse(json['last_synced_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'influencer_id': influencerId,
      'platform': platform,
      'handle': handle,
      'platform_user_id': platformUserId,
      'account_type': accountType,
      'is_verified_connection': isVerifiedConnection,
      'connection_status': connectionStatus,
      'last_synced_at': lastSyncedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}

/// Collaboration request model
class CollaborationRequest {
  final String id;
  final String businessId;
  final String influencerId;
  final String campaignTitle;
  final String outreachNote;
  final String status; // 'pending', 'accepted', 'declined', 'cancelled'
  final bool contactShared;
  final DateTime createdAt;
  final DateTime? respondedAt;

  CollaborationRequest({
    required this.id,
    required this.businessId,
    required this.influencerId,
    required this.campaignTitle,
    required this.outreachNote,
    required this.status,
    required this.contactShared,
    required this.createdAt,
    this.respondedAt,
  });

  factory CollaborationRequest.fromJson(Map<String, dynamic> json) {
    return CollaborationRequest(
      id: json['id'] as String,
      businessId: json['business_id'] as String,
      influencerId: json['influencer_id'] as String,
      campaignTitle: json['campaign_title'] as String,
      outreachNote: json['outreach_note'] as String? ?? '',
      status: json['status'] as String,
      contactShared: json['contact_shared'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      respondedAt: json['responded_at'] != null
          ? DateTime.parse(json['responded_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_id': businessId,
      'influencer_id': influencerId,
      'campaign_title': campaignTitle,
      'outreach_note': outreachNote,
      'status': status,
      'contact_shared': contactShared,
      'created_at': createdAt.toIso8601String(),
      'responded_at': respondedAt?.toIso8601String(),
    };
  }
}
