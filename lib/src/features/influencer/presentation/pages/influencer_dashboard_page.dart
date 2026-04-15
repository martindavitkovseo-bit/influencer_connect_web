import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/app_widgets.dart';
import '../../../../shared/widgets/app_navbar.dart';

class InfluencerDashboardPage extends StatefulWidget {
  const InfluencerDashboardPage({super.key});

  @override
  State<InfluencerDashboardPage> createState() =>
      _InfluencerDashboardPageState();
}

class _InfluencerDashboardPageState extends State<InfluencerDashboardPage> {
  int _selectedTab = 0;

  final List<String> tabs = [
    'Home',
    'Requests',
    'Profile',
    'Notifications',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Creator Dashboard'),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                'Welcome!',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          if (!isSmallScreen)
            SizedBox(
              width: 250,
              child: AppSidebar(
                selectedIndex: _selectedTab,
                onItemSelected: (index) => setState(() => _selectedTab = index),
                items: tabs,
              ),
            ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
                child: _buildTabContent(_selectedTab),
              ),
            ),
          ),
        ],
      ),
      drawer: isSmallScreen
          ? Drawer(
              child: AppSidebar(
                selectedIndex: _selectedTab,
                onItemSelected: (index) {
                  setState(() => _selectedTab = index);
                  Navigator.of(context).pop();
                },
                items: tabs,
              ),
            )
          : null,
    );
  }

  Widget _buildTabContent(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return const _HomeTab();
      case 1:
        return const _RequestsTab();
      case 2:
        return const _ProfileTab();
      case 3:
        return const _NotificationsTab();
      case 4:
        return const _SettingsTab();
      default:
        return const SizedBox();
    }
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.displaySmall,
            children: const [
              TextSpan(text: 'Your '),
              TextSpan(
                text: 'Dashboard',
                style: TextStyle(color: AppTheme.primaryColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Manage collaborations and grow your presence',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        // Stats Grid
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            StatCard(
              icon: Icons.trending_up,
              value: '125K',
              title: 'Total Followers',
              color: AppTheme.primaryColor,
            ),
            StatCard(
              icon: Icons.percent,
              value: '8.5%',
              title: 'Avg Engagement',
              color: AppTheme.secondaryColor,
            ),
            StatCard(
              icon: Icons.mail,
              value: '12',
              title: 'New Requests',
              color: AppTheme.accentColor,
            ),
            StatCard(
              icon: Icons.check_circle,
              value: '5',
              title: 'Accepted Requests',
              color: Colors.orange,
            ),
          ],
        ),
        const SizedBox(height: 32),
        // Quick Actions
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: AppCard(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.image, size: 32, color: AppTheme.primaryColor),
                      const SizedBox(height: 12),
                      const Text(
                        'Update Media Kit',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Share your best content',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppCard(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.analytics, size: 32, color: AppTheme.secondaryColor),
                      const SizedBox(height: 12),
                      const Text(
                        'View Analytics',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Track your growth',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        // Recent Activity
        Text(
          'Recent Activity',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppCard(
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(Icons.campaign, color: Colors.white),
                ),
                title: const Text('New collaboration request'),
                subtitle: const Text('From Brand XYZ • 2 hours ago'),
                trailing: const Icon(Icons.arrow_forward),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RequestsTab extends StatelessWidget {
  const _RequestsTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.displaySmall,
            children: const [
              TextSpan(text: 'Collaboration '),
              TextSpan(
                text: 'Requests',
                style: TextStyle(color: AppTheme.primaryColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Review and respond to brand offers',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        // Status filters
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              'All',
              'Pending',
              'Accepted',
              'Declined',
            ]
                .map(
                  (status) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(status),
                      onSelected: (_) {},
                      backgroundColor: Colors.grey[100],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 24),
        // Request cards
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Summer Campaign',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'From Fashion Brand Co.',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        AppBadge(
                          label: index % 2 == 0 ? 'Pending' : 'Accepted',
                          backgroundColor: index % 2 == 0
                              ? const Color(0xFFF39C12)
                              : AppTheme.secondaryColor,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'We love your content! We\'d like to collaborate on our summer collection launch...',
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        if (index % 2 == 0)
                          Expanded(
                            child: AppButton(
                              label: 'Accept',
                              onPressed: () {},
                              isSmall: true,
                            ),
                          ),
                        if (index % 2 == 0) const SizedBox(width: 8),
                        if (index % 2 == 0)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: const Text('Decline'),
                            ),
                          ),
                        if (index % 2 != 0)
                          Expanded(
                            child: TextButton(
                              onPressed: () {},
                              child: const Text('View Details'),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.displaySmall,
            children: const [
              TextSpan(text: 'Your Creator '),
              TextSpan(
                text: 'Profile',
                style: TextStyle(color: AppTheme.primaryColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'How brands see you',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        // Profile card
        AppCard(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Display Name',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Fashion & Lifestyle',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              AppBadge(
                                label: '125K',
                                backgroundColor: AppTheme.primaryColor,
                                textColor: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              AppBadge(
                                label: '8.5%',
                                backgroundColor: AppTheme.secondaryColor,
                                textColor: Colors.white,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          AppButton(
                            label: 'Edit Profile',
                            onPressed: () {},
                            isSmall: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 24),
                Text(
                  'Bio',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Text(
                  'Your bio appears here. Edit it to tell brands more about yourself and what connects you with your audience.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 24),
                Text(
                  'Connected Platforms',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                ...['Instagram', 'TikTok', 'YouTube'].map(
                  (platform) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(platform),
                        const AppBadge(
                          label: 'Connected',
                          backgroundColor: AppTheme.secondaryColor,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NotificationsTab extends StatelessWidget {
  const _NotificationsTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.displaySmall,
            children: const [
              TextSpan(text: 'Your '),
              TextSpan(
                text: 'Notifications',
                style: TextStyle(color: AppTheme.primaryColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Stay updated on new opportunities',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppCard(
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: [
                      AppTheme.primaryColor,
                      AppTheme.secondaryColor,
                      AppTheme.accentColor,
                      Colors.orange,
                      Colors.purple,
                      Colors.teal,
                    ][index % 6],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(Icons.notifications, color: Colors.white),
                ),
                title: index == 0
                    ? const Text('New collaboration request')
                    : index == 1
                        ? const Text('Request accepted!')
                        : const Text('Brand added you to favorites'),
                subtitle: Text(
                  '${2 + index} hours ago',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SettingsTab extends StatelessWidget {
  const _SettingsTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.displaySmall,
            children: const [
              TextSpan(text: 'Account '),
              TextSpan(
                text: 'Settings',
                style: TextStyle(color: AppTheme.primaryColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Manage your profile and preferences',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        // Settings Sections
        AppCard(
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ListTile(
                title: const Text('Email Notifications'),
                subtitle: const Text('Receive updates about new requests'),
                trailing: Switch(value: true, onChanged: null),
              ),
              const Divider(height: 0),
              ListTile(
                title: const Text('Contact Consent'),
                subtitle: const Text('Allow brands to contact you'),
                trailing: Switch(value: true, onChanged: null),
              ),
              const Divider(height: 0),
              ListTile(
                title: const Text('Privacy Settings'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        AppCard(
          child: ListTile(
            leading: const Icon(Icons.logout, color: AppTheme.errorColor),
            title: const Text(
              'Logout',
              style: TextStyle(color: AppTheme.errorColor),
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
