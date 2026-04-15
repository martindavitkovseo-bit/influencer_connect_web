import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/app_widgets.dart';

class BusinessOnboardingPage extends StatefulWidget {
  const BusinessOnboardingPage({super.key});

  @override
  State<BusinessOnboardingPage> createState() => _BusinessOnboardingPageState();
}

class _BusinessOnboardingPageState extends State<BusinessOnboardingPage> {
  final _formKey = GlobalKey<FormState>();
  final _companyNameController = TextEditingController();
  final _websiteController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedIndustry = '';
  String _selectedCountry = '';
  bool _isLoading = false;
  int _currentStep = 1;

  final List<String> industries = [
    'Tech',
    'Fashion',
    'Beauty',
    'Food & Beverage',
    'Fitness',
    'Travel',
    'Finance',
    'Health',
    'Entertainment',
    'Education',
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

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Setup'),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                'Step $_currentStep of 2',
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
                  value: _currentStep / 2,
                  minHeight: 4,
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation(AppTheme.primaryColor),
                ),
                const SizedBox(height: 32),
                // Step 1: Company Info
                if (_currentStep == 1) ...[
                  Text(
                    'Tell us about your company',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This information helps us connect you with the right creators',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  AppInputField(
                    label: 'Company Name',
                    hint: 'Enter your company name',
                    controller: _companyNameController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Company name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AppInputField(
                    label: 'Website',
                    hint: 'https://yourcompany.com',
                    controller: _websiteController,
                    keyboardType: TextInputType.url,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Website is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Industry',
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
                          value: _selectedIndustry.isEmpty ? null : _selectedIndustry,
                          hint: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('Select your industry'),
                          ),
                          underline: const SizedBox(),
                          items: industries
                              .map(
                                (industry) => DropdownMenuItem(
                                  value: industry,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(industry),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() => _selectedIndustry = value ?? '');
                          },
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  // Step 2: Location & Description
                  Text(
                    'More about your company',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Help creators understand your brand better',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
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
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  const SizedBox(height: 16),
                  AppInputField(
                    label: 'Company Description',
                    hint: 'Tell creators about your brand',
                    controller: _descriptionController,
                    maxLines: 4,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Description is required';
                      }
                      return null;
                    },
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
                        label: _currentStep == 2 ? 'Complete Setup' : 'Next',
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

    if (_currentStep == 1) {
      setState(() => _currentStep++);
    } else {
      _completeOnboarding();
    }
  }

  Future<void> _completeOnboarding() async {
    setState(() => _isLoading = true);

    try {
      // TODO: Save business profile to backend

      if (!mounted) return;
      context.go(AppConstants.businessDashboardRoute);
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
    context.go(AppConstants.businessDashboardRoute);
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _websiteController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
