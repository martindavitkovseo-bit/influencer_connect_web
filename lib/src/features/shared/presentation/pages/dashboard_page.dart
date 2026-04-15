import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/app_navbar.dart';
import '../../../../shared/widgets/app_widgets.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppNavBar(
          currentRoute: AppConstants.dashboardRoute,
          onProfileTap: () => context.go(AppConstants.profileRoute),
          onLogoutTap: _handleLogout,
        ),
      ),
      drawer: !isSmallScreen
          ? null
          : AppSidebar(
              currentRoute: AppConstants.dashboardRoute,
              onProfileTap: () {
                Navigator.pop(context);
                context.go(AppConstants.profileRoute);
              },
              onLogoutTap: () {
                Navigator.pop(context);
                _handleLogout();
              },
            ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isSmallScreen ? 16 : 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeaderSection(isSmallScreen: isSmallScreen),
            const SizedBox(height: 32),
            _StatsSection(isSmallScreen: isSmallScreen),
            const SizedBox(height: 32),
            _RecentActivitySection(isSmallScreen: isSmallScreen),
            const SizedBox(height: 32),
            _QuickActionsSection(isSmallScreen: isSmallScreen),
          ],
        ),
      ),
    );
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go(AppConstants.loginRoute);
            },
            child: Text(
              'Logout',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final bool isSmallScreen;

  const _HeaderSection({required this.isSmallScreen});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back! 👋',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Here\'s what\'s happening with your account today.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _StatsSection extends StatelessWidget {
  final bool isSmallScreen;

  const _StatsSection({required this.isSmallScreen});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Statistics',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: isSmallScreen ? 2 : 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            StatCard(
              title: 'Active Campaigns',
              value: '5',
              icon: Icons.campaign_outlined,
              color: AppTheme.primaryColor,
              onTap: () {},
            ),
            StatCard(
              title: 'Pending Requests',
              value: '12',
              icon: Icons.inbox_outlined,
              color: AppTheme.warningColor,
              onTap: () {},
            ),
            StatCard(
              title: 'Total Earnings',
              value: '\$5,420',
              icon: Icons.attach_money,
              color: AppTheme.successColor,
              onTap: () {},
            ),
            StatCard(
              title: 'Profile Views',
              value: '1,234',
              icon: Icons.visibility_outlined,
              color: AppTheme.accentColor,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _RecentActivitySection extends StatelessWidget {
  final bool isSmallScreen;

  const _RecentActivitySection({required this.isSmallScreen});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextButton(
              onPressed: () {},
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        AppCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _ActivityItem(
                icon: Icons.check_circle,
                title: 'Campaign "Summer Sale" Started',
                description: '2 hours ago',
                color: Colors.green,
              ),
              const Divider(),
              _ActivityItem(
                icon: Icons.person_add,
                title: 'New Collaboration Request',
                description: 'From @brandx_official',
                color: Colors.blue,
              ),
              const Divider(),
              _ActivityItem(
                icon: Icons.trending_up,
                title: 'Profile Views Increased by 120%',
                description: 'Last 7 days',
                color: Colors.deepOrange,
              ),
              const Divider(),
              _ActivityItem(
                icon: Icons.message,
                title: 'New Message',
                description: 'From campaign manager',
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _ActivityItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuickActionsSection extends StatelessWidget {
  final bool isSmallScreen;

  const _QuickActionsSection({required this.isSmallScreen});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            SizedBox(
              width: isSmallScreen
                  ? (MediaQuery.of(context).size.width - 32) / 2 - 6
                  : 160,
              child: AppCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'New Campaign',
                      style: TextStyle(fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: isSmallScreen
                  ? (MediaQuery.of(context).size.width - 32) / 2 - 6
                  : 160,
              child: AppCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.people,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Find Influencers',
                      style: TextStyle(fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: isSmallScreen
                  ? (MediaQuery.of(context).size.width - 32) / 2 - 6
                  : 160,
              child: AppCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.analytics,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'View Analytics',
                      style: TextStyle(fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: isSmallScreen
                  ? (MediaQuery.of(context).size.width - 32) / 2 - 6
                  : 160,
              child: AppCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.settings,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Settings',
                      style: TextStyle(fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
