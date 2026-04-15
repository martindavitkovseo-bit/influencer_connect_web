import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';

class AppNavBar extends StatelessWidget {
  final String currentRoute;
  final VoidCallback? onProfileTap;
  final VoidCallback? onLogoutTap;
  final bool isAuthenticated;

  const AppNavBar({
    super.key,
    required this.currentRoute,
    this.onProfileTap,
    this.onLogoutTap,
    this.isAuthenticated = true,
  });

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.borderColor
                : const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            // Logo/App Name
            GestureDetector(
              onTap: () => context.go(AppConstants.dashboardRoute),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.trending_up,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    if (!isSmallScreen)
                      Text(
                        'Influencer Connect',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // Navigation Links (Hide on small screens)
            if (!isSmallScreen && isAuthenticated) ...[
              _NavBarLink(
                label: 'Dashboard',
                isActive: currentRoute == AppConstants.dashboardRoute,
                onTap: () => context.go(AppConstants.dashboardRoute),
              ),
              _NavBarLink(
                label: 'Influencers',
                isActive: currentRoute == '/influencers',
                onTap: () => context.go('/influencers'),
              ),
              _NavBarLink(
                label: 'Requests',
                isActive: currentRoute == AppConstants.requestsRoute,
                onTap: () => context.go(AppConstants.requestsRoute),
              ),
              _NavBarLink(
                label: 'Profile',
                isActive: currentRoute == AppConstants.profileRoute,
                onTap: () => context.go(AppConstants.profileRoute),
              ),
              const SizedBox(width: 24),
            ],
            // User Menu
            if (isAuthenticated)
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'profile') {
                    onProfileTap?.call();
                  } else if (value == 'logout') {
                    onLogoutTap?.call();
                  }
                },
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(
                    value: 'profile',
                    child: Row(
                      children: [
                        Icon(Icons.person, size: 18),
                        SizedBox(width: 12),
                        Text('Profile'),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, size: 18, color: AppTheme.errorColor),
                        SizedBox(width: 12),
                        Text('Logout', style: TextStyle(color: AppTheme.errorColor)),
                      ],
                    ),
                  ),
                ],
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.account_circle, color: AppTheme.primaryColor),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavBarLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarLink({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavBarLink> createState() => _NavBarLinkState();
}

class _NavBarLinkState extends State<_NavBarLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                widget.label,
                style: TextStyle(
                  fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w500,
                  color: widget.isActive || _isHovered
                      ? AppTheme.primaryColor
                      : Colors.grey[600],
                  fontSize: 15,
                ),
              ),
            ),
            if (widget.isActive)
              Positioned(
                bottom: 0,
                child: Container(
                  width: 4,
                  height: 3,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class AppSidebar extends StatelessWidget {
  final String? currentRoute;
  final int? selectedIndex;
  final Function(int)? onItemSelected;
  final List<String>? items;
  final VoidCallback? onProfileTap;
  final VoidCallback? onLogoutTap;

  const AppSidebar({
    super.key,
    this.currentRoute,
    this.selectedIndex,
    this.onItemSelected,
    this.items,
    this.onProfileTap,
    this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    // New tab-based sidebar for dashboard pages
    if (items != null && selectedIndex != null && onItemSelected != null) {
      return Container(
        color: Colors.grey[50],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Navigation',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items!.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedIndex == index;
                  return ListTile(
                    title: Text(items![index]),
                    selected: isSelected,
                    onTap: () => onItemSelected!(index),
                    selectedTileColor: AppTheme.primaryColor.withOpacity(0.1),
                    leading: isSelected
                        ? Icon(Icons.check_circle, color: AppTheme.primaryColor)
                        : const Icon(Icons.circle_outlined),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    // Legacy drawer-based sidebar
    return Drawer(
      child: Container(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.surfaceColor
            : Colors.white,
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.trending_up, color: Colors.white, size: 32),
                  const SizedBox(height: 12),
                  const Text(
                    'Influencer Connect',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Marketplace Platform',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _SidebarItem(
              icon: Icons.dashboard_rounded,
              label: 'Dashboard',
              isActive: currentRoute == AppConstants.dashboardRoute,
              onTap: () {
                NavigatorState navigator = Navigator.of(context);
                navigator.pop();
                context.go(AppConstants.dashboardRoute);
              },
            ),
            _SidebarItem(
              icon: Icons.people,
              label: 'Influencers',
              isActive: currentRoute == '/influencers',
              onTap: () {
                NavigatorState navigator = Navigator.of(context);
                navigator.pop();
                context.go('/influencers');
              },
            ),
            _SidebarItem(
              icon: Icons.inbox_rounded,
              label: 'Requests',
              isActive: currentRoute == AppConstants.requestsRoute,
              onTap: () {
                NavigatorState navigator = Navigator.of(context);
                navigator.pop();
                context.go(AppConstants.requestsRoute);
              },
            ),
            _SidebarItem(
              icon: Icons.business,
              label: 'Business',
              isActive: currentRoute == AppConstants.businessDashboardRoute,
              onTap: () {
                NavigatorState navigator = Navigator.of(context);
                navigator.pop();
                context.go(AppConstants.businessDashboardRoute);
              },
            ),
            _SidebarItem(
              icon: Icons.person,
              label: 'Profile',
              isActive: currentRoute == AppConstants.profileRoute,
              onTap: () {
                NavigatorState navigator = Navigator.of(context);
                navigator.pop();
                context.go(AppConstants.profileRoute);
              },
            ),
            const Spacer(),
            const Divider(indent: 16, endIndent: 16),
            _SidebarItem(
              icon: Icons.logout,
              label: 'Logout',
              isActive: false,
              onTap: onLogoutTap,
              color: AppTheme.errorColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;
  final Color? color;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.isActive,
    this.onTap,
    this.color,
  });

  @override
  State<_SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<_SidebarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final itemColor = widget.color ?? (widget.isActive ? AppTheme.primaryColor : null);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: ListTile(
        leading: Icon(
          widget.icon,
          color: itemColor ?? (_isHovered ? AppTheme.primaryColor : Colors.grey[600]),
        ),
        title: Text(
          widget.label,
          style: TextStyle(
            fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w500,
            color: itemColor ?? (_isHovered ? AppTheme.primaryColor : null),
          ),
        ),
        selected: widget.isActive,
        selectedTileColor: AppTheme.primaryColor.withOpacity(0.1),
        onTap: widget.onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
