import 'package:flutter/material.dart';

class InfluencersPage extends StatefulWidget {
  const InfluencersPage({super.key});

  @override
  State<InfluencersPage> createState() => _InfluencersPageState();
}

class _InfluencersPageState extends State<InfluencersPage> {
  final _searchController = TextEditingController();
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Browse Influencers')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search influencers',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _CategoryChip(
                    label: 'All',
                    selected: _selectedCategory == 'All',
                    onTap: () => setState(() => _selectedCategory = 'All'),
                  ),
                  const SizedBox(width: 8),
                  _CategoryChip(
                    label: 'Fashion',
                    selected: _selectedCategory == 'Fashion',
                    onTap: () => setState(() => _selectedCategory = 'Fashion'),
                  ),
                  const SizedBox(width: 8),
                  _CategoryChip(
                    label: 'Tech',
                    selected: _selectedCategory == 'Tech',
                    onTap: () => setState(() => _selectedCategory = 'Tech'),
                  ),
                  const SizedBox(width: 8),
                  _CategoryChip(
                    label: 'Lifestyle',
                    selected: _selectedCategory == 'Lifestyle',
                    onTap: () => setState(() => _selectedCategory = 'Lifestyle'),
                  ),
                  const SizedBox(width: 8),
                  _CategoryChip(
                    label: 'Beauty',
                    selected: _selectedCategory == 'Beauty',
                    onTap: () => setState(() => _selectedCategory = 'Beauty'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 120,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.person_outline, size: 50),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Influencer ${index + 1}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'Category',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '50K followers',
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                ),
                                onPressed: () {},
                                child: const Text('View Profile'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      backgroundColor: Colors.grey[200],
      selectedColor: Colors.deepPurple,
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.black,
      ),
    );
  }
}
