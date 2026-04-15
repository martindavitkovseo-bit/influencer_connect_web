import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/app_widgets.dart';

class InfluencerOnboardingPage extends StatefulWidget {
  const InfluencerOnboardingPage({super.key});

  @override
  State<InfluencerOnboardingPage> createState() =>
      _InfluencerOnboardingPageState();
}

class _InfluencerOnboardingPageState extends State<InfluencerOnboardingPage> {
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final _bioController = TextEditingController();
  String _selectedNiche = '';
  String _selectedCountry = '';
  String _selectedLanguage = '';
  List<String> _selectedPlatforms = [];
  bool _isLoading = false;
  int _currentStep = 1;

  final List<String> niches = [
    'Fashion',
    'Beauty',
    'Tech',
    'Fitness',
    'Travel',
    'Food',
    'Lifestyle',
    'Entertainment',
    'Gaming',
    'Education',
    'Health',
    'Business',
    'Other',
  ];

  final List<String> countries = [
    'United States',
    'Canada',
    'United Kingdom',
    'Australia',
    'Germany',
    'France',
    'India',
    'Brazil',
    'Mexico',
    'Other',
  ];

  final List<String> languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Portuguese',
    'Italian',
    'Dutch',
    'Other',
  ];

  final List<String> platforms = [
    'Instagram',
    'TikTok',
    'YouTube',
    'Twitter/X',
    'LinkedIn',
    'Twitch',
  ];

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Profile'),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                'Step $_currentStep of 3',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress indicator
                LinearProgressIndicator(
                  value: _currentStep / 3,
                  minHeight: 4,
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation(AppTheme.primaryColor),
                ),
                const SizedBox(height: 32),
                // Step 1: Basic Info
                if (_currentStep == 1) ...[
                  Text(
                    'Let\'s get to know you',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create your creator profile',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  AppInputField(
                    label: 'Display Name',
                    hint: 'How should brands see you?',
                    controller: _displayNameController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Display name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AppInputField(
                    label: 'Bio',
                    hint: 'Tell brands about yourself (max 200 chars)',
                    controller: _bioController,
                    maxLines: 3,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Bio is required';
                      }
                      if (value!.length > 200) {
                        return 'Bio must be less than 200 characters';
                      }
                      return null;
                    },
                  ),
                ] else if (_currentStep == 2) ...[
                  // Step 2: Niche & Location
                  Text(
                    'Your Content Niche',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Help brands find you',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Primary Niche',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedNiche.isEmpty ? null : _selectedNiche,
                          hint: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('Select your niche'),
                          ),
                          underline: const SizedBox(),
                          items: niches
                              .map(
                                (niche) => DropdownMenuItem(
                                  value: niche,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(niche),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() => _selectedNiche = value ?? '');
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Country',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedCountry.isEmpty ? null : _selectedCountry,
                          hint: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('Select your country'),
                          ),
                          underline: const SizedBox(),
                          items: countries
                              .map(
                                (country) => DropdownMenuItem(
                                  value: country,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(country),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() => _selectedCountry = value ?? '');
                          },
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  // Step 3: Platforms
                  Text(
                    'Where Do You Create?',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Select all platforms where you\'re active',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Primary Language',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedLanguage.isEmpty ? null : _selectedLanguage,
                          hint: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('Select your language'),
                          ),
                          underline: const SizedBox(),
                          items: languages
                              .map(
                                (lang) => DropdownMenuItem(
                                  value: lang,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(lang),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() => _selectedLanguage = value ?? '');
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Platforms',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: platforms.map((platform) {
                          final isSelected = _selectedPlatforms.contains(platform);
                          return FilterChip(
                            selected: isSelected,
                            label: Text(platform),
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedPlatforms.add(platform);
                                } else {
                                  _selectedPlatforms.remove(platform);
                                }
                              });
                            },
                            backgroundColor: Colors.grey[100],
                            selectedColor: AppTheme.primaryColor.withOpacity(0.1),
                            labelStyle: TextStyle(
                              color:
                                  isSelected ? AppTheme.primaryColor : Colors.black,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 32),
                // Navigation buttons
                Row(
                  children: [
                    if (_currentStep > 1)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => setState(() => _currentStep--),
                          child: const Text('Back'),
                        ),
                      ),
                    if (_currentStep > 1) const SizedBox(width: 16),
                    Expanded(
                      child: AppButton(
                        label: _currentStep == 3 ? 'Complete Profile' : 'Next',
                        isLoading: _isLoading,
                        onPressed: () => _handleNext(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: _isLoading ? null : () => _skipOnboarding(),
                    child: const Text('Skip for now'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleNext() {
    if (!_formKey.currentState!.validate()) return;

    if (_currentStep < 3) {
      setState(() => _currentStep++);
    } else {
      _completeOnboarding();
    }
  }

  Future<void> _completeOnboarding() async {
    setState(() => _isLoading = true);

    try {
      // TODO: Save influencer profile to backend

      if (!mounted) return;
      context.go(AppConstants.influencerDashboardRoute);
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

  void _skipOnboarding() {
    context.go(AppConstants.influencerDashboardRoute);
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }
}
