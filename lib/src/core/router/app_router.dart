import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/role_selection_page.dart';
import '../../features/business/presentation/pages/business_dashboard_page.dart';
import '../../features/influencer/presentation/pages/influencer_dashboard_page.dart';
import '../../features/influencers/presentation/pages/influencers_page.dart';
import '../../features/onboarding/presentation/pages/business_onboarding_page.dart';
import '../../features/onboarding/presentation/pages/influencer_onboarding_page.dart';
import '../../features/profiles/presentation/pages/profile_page.dart';
import '../../features/requests/presentation/pages/requests_page.dart';
import '../../features/shared/presentation/pages/dashboard_page.dart';
import '../constants/app_constants.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppConstants.homeRoute,
    routes: [
      GoRoute(
        path: AppConstants.homeRoute,
        builder: (context, state) => const HomeRedirectPage(),
      ),
      GoRoute(
        path: AppConstants.loginRoute,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppConstants.registerRoute,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: AppConstants.roleSelectionRoute,
        builder: (context, state) => const RoleSelectionPage(),
      ),
      GoRoute(
        path: AppConstants.dashboardRoute,
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: AppConstants.profileRoute,
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: AppConstants.businessDashboardRoute,
        builder: (context, state) => const BusinessDashboardPage(),
      ),
      GoRoute(
        path: AppConstants.businessOnboardingRoute,
        builder: (context, state) => const BusinessOnboardingPage(),
      ),
      GoRoute(
        path: AppConstants.influencerDashboardRoute,
        builder: (context, state) => const InfluencerDashboardPage(),
      ),
      GoRoute(
        path: AppConstants.influencerOnboardingRoute,
        builder: (context, state) => const InfluencerOnboardingPage(),
      ),
      GoRoute(
        path: AppConstants.requestsRoute,
        builder: (context, state) => const RequestsPage(),
      ),
      GoRoute(
        path: '/influencers',
        builder: (context, state) => const InfluencersPage(),
      ),
    ],
  );
});

class HomeRedirectPage extends StatelessWidget {
  const HomeRedirectPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Redirect directly to login page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go(AppConstants.loginRoute);
    });
    
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
