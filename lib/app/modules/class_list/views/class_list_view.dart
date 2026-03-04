import 'package:fitpall/app/theme/app_colors.dart';
import 'package:fitpall/app/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/class_list_controller.dart';

class ClassListView extends GetView<ClassListController> {
  const ClassListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================== HEADER ====================
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 62, 20, 20),
              child: Row(
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('Class list', style: AppText.Heading2),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ==================== FILTER ====================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() => _buildFilterRow()),
            ),

            const SizedBox(height: 20),

            // ==================== CLASS LIST ====================
            Expanded(
              child: Obx(() {
                final classes = controller.filteredClasses;

                if (classes.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.fitness_center, size: 60, color: Colors.grey.shade300),
                        const SizedBox(height: 12),
                        Text(
                          'No classes found',
                          style: AppText.Body.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                  itemCount: classes.length,
                  itemBuilder: (context, index) {
                    final classItem = classes[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildClassCard(classItem),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== FILTER ROW ====================
  Widget _buildFilterRow() {
    return Row(
      children: controller.filters.map((filter) {
        final isSelected = controller.selectedGender.value == filter;
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () => controller.selectGender(filter),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF0B0C4F) : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF0B0C4F)
                      : const Color(0xFFD0D0D0),
                  width: 1.5,
                ),
              ),
              child: Text(
                filter,
                style: AppText.Body.copyWith(
                  color: isSelected ? Colors.white : const Color(0xFF1A1A1A),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ==================== CLASS CARD ====================
  Widget _buildClassCard(Map<String, dynamic> classItem) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            // ===== IMAGE SECTION =====
            SizedBox(
              height: 180,
              child: Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: Image.asset(
                      classItem['image']!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFF2A2A2A),
                        child: Center(
                          child: Icon(
                            Icons.fitness_center,
                            size: 50,
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Gender & Date (top)
                  Positioned(
                    top: 12,
                    left: 14,
                    right: 14,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          classItem['gender']!,
                          style: GoogleFonts.poppins(
                            color: AppColors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          classItem['date']!,
                          style: GoogleFonts.poppins(
                            color: AppColors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Title & See Details (bottom)
                  Positioned(
                    bottom: 14,
                    left: 14,
                    right: 14,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Title
                        Expanded(
                          child: Text(
                            classItem['title']!,
                            style: GoogleFonts.poppins(
                              color: AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        const SizedBox(width: 52),

                        // See Details button
                        GestureDetector(
                          onTap: () => controller.onDetailTap(classItem['id']!),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              'See Details',
                              style: AppText.Body_bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ===== BOOK SECTION (orange bar) =====
            Container(
              color: const Color(0xFFFE8400),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  // Text
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Book this class for ',
                            style: AppText.Body.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          TextSpan(
                            text: classItem['price'],
                            style: AppText.Body_bold.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          TextSpan(
                            text: ' only!',
                            style: AppText.Body.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Book button
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        'Book',
                        style: AppText.Body_bold
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}