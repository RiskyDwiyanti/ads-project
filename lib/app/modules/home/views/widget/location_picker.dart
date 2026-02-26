import 'package:fitpall/app/modules/home/controllers/home_controller.dart';
import 'package:fitpall/app/theme/app_colors.dart';
import 'package:fitpall/app/theme/app_text.dart';
import 'package:flutter/material.dart';

class LocationPickerSheet extends StatefulWidget {
  final HomeController controller;
  const LocationPickerSheet({super.key, required this.controller});

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
    final filteredLocations = widget.controller.locations
        .where((loc) => loc['name']!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.60,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          const SizedBox(height: 12),
          Container(
            width: 100,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFD0D0D0),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE6E6E6),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: AppText.Body.copyWith(
                    color: Color(0xFF6C6C6C)
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Location list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: filteredLocations.length,
              separatorBuilder: (_, __) => Divider(height: 2, color: Color(0xFFE6E6E6).withOpacity(0.8)),
              itemBuilder: (context, index) {
                final loc = filteredLocations[index];
                final isSelected = widget.controller.selectedLocationId.value == loc['id'];

                return GestureDetector(
                  onTap: () {
                    widget.controller.selectLocation(loc['id']!);
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      children: [
                        // Gym image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            loc['image']!,
                            width: 62,
                            height: 62,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 62,
                              height: 62,
                              color: const Color(0xFFEEEEEE),
                              child: const Icon(Icons.fitness_center, color: Color(0xFFAAAAAA)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),

                        // Name & address
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                loc['name']!,
                                style: AppText.Body_bold),
                              const SizedBox(height: 8),
                              Text(
                                '${loc['city']}  •  ${loc['distance']}',
                                style: AppText.Body.copyWith(
                                  color: const Color(0xFF6C6C6C)
                                )
                              ),
                            ],
                          ),
                        ),

                        // Checkmark jika lokasi sedang aktif
                        if (isSelected)
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check, color: Colors.white, size: 16),
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