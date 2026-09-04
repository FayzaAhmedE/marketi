import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> _popularSearches = [
    'Pampers',
    'Toothpaste',
    'iPhone',
    'pants',
    'Laptop',
    'Fried Chicken',
    'Sugar',
    'Smart TV',
    'Xbox',
  ];

  final List<String> _searchHistory = [
    'iphone XS Max',
    'Laptop Lenovo ideapad 3',
    'White Sweet Pants',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar with Back Arrow and Profile Avatar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/profile.png'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Search Text Field
              TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'What are you looking for ?',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: Container(
                    margin: const EdgeInsets.all(6),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.tune,
                      color: AppColors.primary,
                      size: 18,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue.shade100),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue.shade100),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Popular Search Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Popular Search',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0C1D37),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Color(0xFF0C1D37)),
                ],
              ),
              const SizedBox(height: 12),

              // Popular Search Wrap Chips
              Wrap(
                spacing: 8,
                runSpacing: 10,
                children: _popularSearches.map((item) {
                  return InkWell(
                    onTap: () {
                      _searchController.text = item;
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F1FF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        item,
                        style: const TextStyle(
                          color: Color(0xFF2F80ED),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Search History Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Search History',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0C1D37),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Color(0xFF0C1D37)),
                ],
              ),
              const SizedBox(height: 8),

              // Search History Items List
              Expanded(
                child: ListView.separated(
                  itemCount: _searchHistory.length,
                  separatorBuilder: (context, index) =>
                      Divider(color: Colors.grey.shade200, height: 1),
                  itemBuilder: (context, index) {
                    final item = _searchHistory[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _searchHistory.removeAt(index);
                              });
                            },
                            child: const Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
