import 'package:flutter_riverpod/flutter_riverpod.dart';

// Models - simplified for now, should be imported from models file
class User {
  final String id;
  final String email;
  final String fullName;
  final String role; // 'business', 'influencer', 'admin'
  final bool onboardingComplete;

  User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    required this.onboardingComplete,
  });
}

/// Current authenticated user state
final currentUserProvider = StateNotifierProvider<CurrentUserNotifier, User?>((ref) {
  return CurrentUserNotifier();
});

class CurrentUserNotifier extends StateNotifier<User?> {
  CurrentUserNotifier() : super(null);

  void setUser(User user) {
    state = user;
  }

  void logout() {
    state = null;
  }

  void updateUser(User user) {
    state = user;
  }
}

/// Current user's role
final userRoleProvider = Provider<String?>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.role;
});

/// Check if user has completed onboarding
final isOnboardingCompleteProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.onboardingComplete ?? false;
});

/// Loading and error state providers
final isLoadingProvider = StateProvider<bool>((ref) => false);
final errorMessageProvider = StateProvider<String?>((ref) => null);

/// Business favorites (saved influencers)
final businessFavoritesProvider = StateNotifierProvider<FavoritesNotifier, List<String>>((ref) {
  return FavoritesNotifier();
});

class FavoritesNotifier extends StateNotifier<List<String>> {
  FavoritesNotifier() : super([]);

  void addFavorite(String influencerId) {
    if (!state.contains(influencerId)) {
      state = [...state, influencerId];
    }
  }

  void removeFavorite(String influencerId) {
    state = state.where((id) => id != influencerId).toList();
  }

  bool isFavorite(String influencerId) {
    return state.contains(influencerId);
  }
}

// Collaboration requests
final collaborationRequestsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  // TODO: Implement API call
  return [];
});

// Business profile data
final businessProfileProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  // TODO: Implement API call
  return null;
});

// Opportunities for influencers
final opportunitiesProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  // TODO: Implement API call
  return [];
});
