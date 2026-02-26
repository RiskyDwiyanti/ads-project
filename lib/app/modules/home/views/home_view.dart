import 'package:fitpall/app/modules/home/views/widget/judge.dart';
import 'package:fitpall/app/modules/home/views/widget/location_picker.dart';
import 'package:fitpall/app/routes/app_pages.dart';
import 'package:fitpall/app/theme/app_colors.dart';
import 'package:fitpall/app/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    decoration: const BoxDecoration(
                      color: Colors.white,
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
              color: Colors.white,
              child: Column(
                children: [
                  _buildFeaturedClassesSection(),
                  const SizedBox(height: 30),
                  _buildJudgesSection(),
                  const SizedBox(height: 160),
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
                    builder: (_) => LocationPickerSheet(controller: controller),
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
                        Obx(() => Text(
                          controller.locations.firstWhere(
                            (loc) => loc['id'] == controller.selectedLocationId.value,
                          )['name'] ?? 'Select Location',
                          style: AppText.Body_bold.copyWith(color: Colors.white),
                        )),
                      ],
                    ),
                  ),
                ),

                // Actions
                Row(
                  children: [
                    _iconBox(Icons.shopping_cart),
                    const SizedBox(width: 16),
                    _iconBox(Icons.notifications),
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

  // ==================== FEATURED CLASSES ====================
  Widget _buildFeaturedClassesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Featured Classes', style: AppText.Heading2),
                  const SizedBox(height: 4),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: AppText.Body_bold.copyWith(color: const Color(0xFFFE8400)),
                    ),
                  ),
                ],
              ),
              Text(
                'Join the competition now!',
                style: AppText.Body.copyWith(color: const Color(0xFF6C6C6C)),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Obx(() => _buildGenderFilter()),
        ),
        const SizedBox(height: 20),
        Obx(() => SizedBox(
          height: 163,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: controller.filteredClasses.length,
            itemBuilder: (context, index) {
              final classItem = controller.filteredClasses[index];
              return _buildClassCard(
                title: classItem['title']!,
                date: classItem['date']!,
                gender: classItem['gender']!,
                image: classItem['image']!,
                price: classItem['price']!,
                time: classItem['time']!,
              );
            },
          ),
        )),
      ],
    );
  }

  Widget _buildGenderFilter() {
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
                color: isSelected ? const Color(0xFF0B0C4F) : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isSelected ? const Color(0xFF0B0C4F) : const Color(0xFF6C6C6C),
                  width: 1.5,
                ),
              ),
              child: Text(
                gender,
                style: AppText.Body.copyWith(
                  color: isSelected ? Colors.white : const Color(0xFF000000),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildClassCard({
    required String title,
    required String date,
    required String gender,
    required String image,
    required int price,
    required String time,
  }) {
    return Container(
      width: 373,
      height: 163,
      margin: const EdgeInsets.only(right: 16),
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
                      Text(gender, style: GoogleFonts.poppins(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400)),
                      Text(date, style: GoogleFonts.poppins(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600, height: 1.2),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 28),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            Routes.CLASS_DETAIL,
                            arguments: {
                              'title': title,
                              'date': date,
                              'gender': gender,
                              'image': image,
                              'price': price,
                              'time': time,
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                          child: Text(
                            'See Details',
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

  // ==================== JUDGES ====================
  Widget _buildJudgesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Meet Our Judges', style: AppText.Heading2),
              const SizedBox(height: 4),
              Text(
                'The true icons of Indonesia\'s bodybuilding',
                style: AppText.Body.copyWith(color: const Color(0xFF6C6C6C)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 243,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: controller.judges.length,
            itemBuilder: (context, index) {
              final judge = controller.judges[index];
              return _buildJudgeCard(
                name: judge['name']!,
                description: judge['description']!,
                image: judge['image']!,
              );
            },
          ),
        ),
      ],
    );
  }

  // Judge Card — bisa diklik, buka JudgeDetailDialog di tengah layar
  Widget _buildJudgeCard({
    required String name,
    required String description,
    required String image,
  }) {
    return GestureDetector(
      onTap: () {
        Get.dialog(
          JudgeDetailDialog(
            name: name,
            description: description,
            image: image,
          ),
        );
      },
      child: Container(
        width: 204,
        margin: const EdgeInsets.only(right: 16),
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
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppText.Subheading_Bold.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: const Color(0xFFFE8400),
                        decorationThickness: 3,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: AppText.Body.copyWith(color: AppColors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== Icon ====================
  Widget _iconBox(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }
}