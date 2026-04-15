import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/app_widgets.dart';
import '../../../../shared/widgets/app_navbar.dart';

class BusinessDashboardPage extends StatefulWidget {
  const BusinessDashboardPage({super.key});

  @override
  State<BusinessDashboardPage> createState() => _BusinessDashboardPageState();
}

class _BusinessDashboardPageState extends State<BusinessDashboardPage> {
  int _selectedTab = 0;

  final List<String> tabs = [
    'Discover',
    'Requests',
    'Favorites',
    'Notifications',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Dashboard'),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                'Welcome back!',
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
        return const _DiscoverTab();
      case 1:
        return const _RequestsTab();
      case 2:
        return const _FavoritesTab();
      case 3:
        return const _NotificationsTab();
      case 4:
        return const _ProfileTab();
      default:
        return const SizedBox();
    }
  }
}

class _DiscoverTab extends StatelessWidget {
  const _DiscoverTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.displaySmall,
            children: const [
              TextSpan(text: 'Discover '),
              TextSpan(
                text: 'Influencers',
                style: TextStyle(color: AppTheme.primaryColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Find the perfect creators for your next campaign',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        // Filters
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filter by',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    'Platform',
                    'Niche',
                    'Country',
                    'Followers',
                    'Language',
                  ]
                      .map(
                        (filter) => InputChip(
                          label: Text(filter),
                          onPressed: () {},
                          backgroundColor: Colors.grey[100],
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Featured influencers
        Text(
          'Top Influencers',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: 4,
          itemBuilder: (context, index) => const _InfluencerCard(),
        ),
      ],
    );
  }
}

class _InfluencerCard extends StatelessWidget {
  const _InfluencerCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Creator Name',
            style: TextStyle(fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
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
          const Spacer(),
          AppButton(
            label: 'Connect',
            onPressed: () {},
            isSmall: true,
          ),
        ],
      ),
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
          'Track your outreach and collaboration status',
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
        // Request list
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) => const _RequestCard(),
        ),
      ],
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
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
                        'Summer Product Launch',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Sent to Creator Name',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const AppBadge(
                  label: 'Pending',
                  backgroundColor: Color(0xFFF39C12),
                  textColor: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Looking for a fashion influencer to promote our new summer collection...',
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Sent 2 days ago',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoritesTab extends StatelessWidget {
  const _FavoritesTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.displaySmall,
            children: const [
              TextSpan(text: 'Saved '),
              TextSpan(
                text: 'Influencers',
                style: TextStyle(color: AppTheme.primaryColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your collection of favorite creators',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
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
                ),
                title: const Text('Creator Name'),
                subtitle: const Text('Fashion • 125K followers'),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
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
          'Stay updated on collaboration requests',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
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
                    ][index % 4],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(Icons.notifications, color: Colors.white),
                ),
                title: const Text('Creator accepted your request'),
                subtitle: const Text('2 hours ago'),
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
              TextSpan(text: 'Your Company '),
              TextSpan(
                text: 'Profile',
                style: TextStyle(color: AppTheme.primaryColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'How creators see your business',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
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
                            'Your Company Name',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Fashion • United States',
                            style: Theme.of(context).textTheme.bodySmall,
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
                  'Company Description',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Text(
                  'Your company description appears here. Edit it to tell creators more about your brand and values.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
