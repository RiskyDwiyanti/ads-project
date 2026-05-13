import 'package:flutter/material.dart';
import 'package:fitpall/app/theme/app_text.dart';
import 'package:fitpall/app/theme/app_colors.dart';

class LocationPickerSheet extends StatefulWidget {
  final List locations;
  final String selectedId;
  final Function(String id) onSelect;

  const LocationPickerSheet({
    super.key,
    required this.locations,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  State<LocationPickerSheet> createState() => _LocationPickerSheetState();
}

class _LocationPickerSheetState extends State<LocationPickerSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredLocations = widget.locations.where((loc) {
      final name = (loc['name'] ?? '').toString().toLowerCase();
      return name.contains(_searchQuery.toLowerCase());
    }).toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.60,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),

          // Handle bar
          Container(
            width: 110,
            height: 7,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 20),

          // Search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: AppText.Body.copyWith(
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 20,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: filteredLocations.length,
              separatorBuilder: (_, __) => Divider(
                height: 2,
                color: Theme.of(context).dividerColor,
              ),
              itemBuilder: (context, index) {
                final loc = filteredLocations[index];

                final isSelected =
                    widget.selectedId == loc['id'].toString();

                return GestureDetector(
                  onTap: () {
                    widget.onSelect(loc['id'].toString());
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      children: [
                        // Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            loc['image'] ?? '',
                            width: 62,
                            height: 62,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 62,
                              height: 62,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onTertiary,
                              child: const Icon(Icons.fitness_center),
                            ),
                          ),
                        ),

                        const SizedBox(width: 20),

                        // Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                loc['name'] ?? '',
                                style: AppText.Body_bold.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${loc['city'] ?? ''} • ${loc['distance'] ?? ''}',
                                style: AppText.Body.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Check
                        if (isSelected)
                          Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: AppColors.secondary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}