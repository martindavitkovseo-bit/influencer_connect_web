// Application constants
class AppConstants {
  static const String appName = 'Influencer Connect';

  // Routes
  static const String homeRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String roleSelectionRoute = '/role-selection';
  static const String onboardingRoute = '/onboarding';
  static const String businessOnboardingRoute = '/onboarding/business';
  static const String influencerOnboardingRoute = '/onboarding/influencer';

  // Business routes
  static const String businessDashboardRoute = '/business/dashboard';
  static const String businessProfileRoute = '/business/profile';
  static const String discoverRoute = '/business/discover';
  static const String favoritesRoute = '/business/favorites';
  static const String businessRequestsRoute = '/business/requests';

  // Influencer routes
  static const String influencerDashboardRoute = '/influencer/dashboard';
  static const String influencerProfileRoute = '/influencer/profile';
  static const String influencerRequestsRoute = '/influencer/requests';
  static const String socialStatsRoute = '/influencer/social-stats';

  // Shared routes
  static const String dashboardRoute = '/dashboard';
  static const String profileRoute = '/profile';
  static const String requestsRoute = '/requests';
  static const String notificationsRoute = '/notifications';
  static const String settingsRoute = '/settings';

  // User roles
  static const String roleBusinessUser = 'business';
  static const String roleInfluencer = 'influencer';
  static const String roleAdmin = 'admin';

  // Request statuses
  static const String requestStatusPending = 'pending';
  static const String requestStatusAccepted = 'accepted';
  static const String requestStatusDeclined = 'declined';
  static const String requestStatusCancelled = 'cancelled';

  // Pagination
  static const int pageSize = 20;

  // Validation
  static const int minPasswordLength = 6;
  static const int maxBioLength = 500;
}
