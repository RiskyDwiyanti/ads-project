import 'package:fitpall/app/modules/athlete/home/views/widget/location_picker.dart';
import 'package:fitpall/app/routes/app_pages.dart';
import 'package:fitpall/app/theme/app_colors.dart';
import 'package:fitpall/app/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_judge_controller.dart';

class HomeJudgeView extends GetView<HomeJudgeController> {
  const HomeJudgeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ==================== BANNER SECTION ====================
            Stack(
              children: [
                _buildBanner(),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ==================== CONTENT SECTION ====================
            Container(
              color: Theme.of(context).colorScheme.background,
              child: Column(
                children: [
                  _buildActiveClassesSection(context),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== BANNER ====================
  Widget _buildBanner() {
    return SizedBox(
      height: 320,
      child: PageView.builder(
        onPageChanged: controller.changeBannerIndex,
        itemCount: controller.banners.length,
        itemBuilder: (context, index) {
          return _buildBannerItem(
            title: controller.banners[index]['title']!,
            subtitle: controller.banners[index]['subtitle']!,
            currentIndex: index,
            totalPages: controller.banners.length,
          );
        },
      ),
    );
  }

  Widget _buildBannerItem({
    required String title,
    required String subtitle,
    required int currentIndex,
    required int totalPages,
  }) {
    final imageUrl = controller.banners[currentIndex]['image'] ?? '';

    return Container(
      width: double.infinity,
      height: 320,
      child: Stack(
        children: [
          // Image Background
          Positioned.fill(
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFFFF6347),
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                );
              },
            ),
          ),

          // Header
          Positioned(
            top: 62,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Location Button
                GestureDetector(
                  onTap: () => showModalBottomSheet(
                    context: Get.context!,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => LocationPickerSheet(
                      locations: controller.locations,
                      selectedId: controller.selectedLocationId.value,
                      onSelect: (id) => controller.selectedLocationId(id),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on, size: 20, color: Colors.white),
                        const SizedBox(width: 8),
                        Obx(() {
                          final selected = controller.locations.firstWhere(
                            (loc) => loc['id'] == controller.selectedLocationId.value,
                            orElse: () => {'name': 'Select Location'}, // ✅ tambah ini
                          );
                          return Text(
                            selected['name'] ?? 'Select Location',
                            style: AppText.Body_bold.copyWith(color: Colors.white),
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                // Actions
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.PROFILE_JUDGE),
                      child: SvgPicture.asset(
                        'assets/icons/profile_icon.svg',
                        width: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Content
          Positioned(
            left: 24,
            right: 20,
            bottom: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.Subheading_Bold.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.Body.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${currentIndex + 1}/$totalPages',
                    style: AppText.Body.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== ACTIVE CLASSES ====================
  Widget _buildActiveClassesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title & See All
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Active Classes', style: AppText.Heading2.copyWith(color: Theme.of(context).colorScheme.onBackground)),
              TextButton(
                onPressed: () {
                  
                },
                child: Text('See All', style: AppText.Body_bold.copyWith(color: AppColors.primary)),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Text(
            'Lorem Ipsum Dolor sit Amet.',
            style: AppText.Body.copyWith(color: Theme.of(context).colorScheme.onTertiary),
          ),
        ),

        // Gender Filter
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Obx(() => _buildGenderFilter(context)),
        ),

        const SizedBox(height: 20),

        // Class List
        Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: controller.filteredActiveClasses.map((classItem) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildActiveClassCard(
                  title: classItem['title']!, 
                  stage: classItem['stage']!, 
                  gender: classItem['gender']!, 
                  image: classItem['image']!
                ), 
              );
            }).toList(),
          ),
        )),
      ],
    );
  }

  Widget _buildActiveClassCard({
    required String title,
    required String stage,
    required String gender,
    required String image,
  }) {
    return Container(
      width: double.infinity,
      height: 163,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Positioned.fill(child: Image.asset(image, fit: BoxFit.cover)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        gender, 
                        style: GoogleFonts.poppins(
                          color: Colors.white, 
                          fontSize: 15, 
                          fontWeight: FontWeight.w400
                        )
                      ),
                      Text(
                        stage, 
                        style: GoogleFonts.poppins(
                          color: Colors.white, 
                          fontSize: 15, 
                          fontWeight: FontWeight.w600
                        )
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.poppins(
                            color: Colors.white, 
                            fontSize: 20, 
                            fontWeight: FontWeight.w600, 
                            height: 1.2
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 28),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            Routes.SCORING,
                            arguments: {
                              'title': title,
                              'gender': gender,
                              'stage': stage,
                            }
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                          child: Text(
                            'Vote',
                            style: GoogleFonts.poppins(color: AppColors.black, fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

   Widget _buildGenderFilter(BuildContext context) {
    final genders = ['All', 'Male', 'Female'];
    return Row(
      children: genders.map((gender) {
        final isSelected = controller.selectedGender.value == gender;
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: GestureDetector(
            onTap: () => controller.selectGender(gender),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isSelected ? Theme.of(context).colorScheme.secondary : const Color(0xFF6C6C6C),
                  width: 1.5,
                ),
              ),
              child: Text(
                gender,
                style: AppText.Body.copyWith(
                  color: isSelected ? Colors.white : Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

}
