import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/app_widgets.dart';

class RoleSelectionPage extends StatefulWidget {
  const RoleSelectionPage({super.key});

  @override
  State<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> {
  String? selectedRole;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              // Top bar
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Influencer Connect',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.go(AppConstants.loginRoute),
                      child: const Text('Back to Login'),
                    ),
                  ],
                ),
              ),
              // Main content
              Center(
                child: Padding(
                  padding: EdgeInsets.all(isLargeScreen ? 48 : 24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Choose Your Role',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Select how you\'d like to use Influencer Connect',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 40),
                        // Business role option
                        _RoleCard(
                          selected: selectedRole == AppConstants.roleBusinessUser,
                          onTap: () {
                            setState(
                              () => selectedRole = AppConstants.roleBusinessUser,
                            );
                          },
                          icon: Icons.business,
                          title: 'I\'m a Business',
                          description:
                              'Find influencers for brand collaborations and campaigns',
                          benefits: [
                            'Browse verified influencers',
                            'Filter by niche and audience',
                            'Send collaboration requests',
                            'Manage campaigns',
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Influencer role option
                        _RoleCard(
                          selected: selectedRole == AppConstants.roleInfluencer,
                          onTap: () {
                            setState(
                              () => selectedRole = AppConstants.roleInfluencer,
                            );
                          },
                          icon: Icons.person_3,
                          title: 'I\'m an Influencer',
                          description:
                              'Showcase your profile and receive collaboration offers',
                          benefits: [
                            'Create impressive profile',
                            'Connect social accounts',
                            'Receive requests',
                            'Build partnerships',
                          ],
                        ),
                        const SizedBox(height: 40),
                        // Continue button
                        SizedBox(
                          width: double.infinity,
                          child: AppButton(
                            label: selectedRole == null ? 'Select a Role' : 'Continue',
                            isLoading: _isLoading,
                            onPressed: selectedRole == null
                                ? () {}
                                : () => _handleContinue(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleContinue(BuildContext context) async {
    if (selectedRole == null) return;

    setState(() => _isLoading = true);

    try {
      // TODO: Save role to backend and user profile

      if (!mounted) return;

      // Route to appropriate onboarding page
      if (selectedRole == AppConstants.roleBusinessUser) {
        context.go(AppConstants.businessOnboardingRoute);
      } else {
        context.go(AppConstants.influencerOnboardingRoute);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}

class _RoleCard extends StatefulWidget {
  final bool selected;
  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final String description;
  final List<String> benefits;

  const _RoleCard({
    required this.selected,
    required this.onTap,
    required this.icon,
    required this.title,
    required this.description,
    required this.benefits,
  });

  @override
  State<_RoleCard> createState() => _RoleCardState();
}

class _RoleCardState extends State<_RoleCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.selected
                  ? AppTheme.primaryColor
                  : (_isHovered ? AppTheme.primaryColor.withOpacity(0.5) : Colors.grey[300]!),
              width: widget.selected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(16),
            color: widget.selected
                ? AppTheme.primaryColor.withOpacity(0.05)
                : Colors.white,
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.icon,
                      color: AppTheme.primaryColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Checkbox(
                    value: widget.selected,
                    onChanged: (_) => widget.onTap(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                widget.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.benefits
                    .map(
                      (benefit) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: AppTheme.successColor,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                benefit,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
