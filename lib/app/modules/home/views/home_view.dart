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
                // Banner dengan image
                _buildBanner(),
                
                // White rounded overlay di bawah banner
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
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
                  // Featured Classes
                  _buildFeaturedClassesSection(),

                  const SizedBox(height: 30),

                  // Judges
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

  // Banner Item 
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
                  color: Color(0xFFFF6347),
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
                // Location
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'GymFit Malang',
                            style: AppText.Body_bold.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Actions
                Row(
                  children: [
                    _iconBox(Icons.shopping_cart),
                    SizedBox(width: 16),
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
                // TEXT KIRI
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.Subheading_Bold.copyWith(
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.Body.copyWith(
                          color: Colors.white,
                        )
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // INDICATOR KANAN
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${currentIndex + 1}/$totalPages',
                    style: AppText.Body.copyWith(
                      color: Colors.white,
                    )
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
        // Title & See All
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Classes',
                    style: AppText.Heading2,
                  ),
                  SizedBox(height: 4),
                  TextButton(
                    onPressed: () {}, 
                    child: Text(
                      'See All',
                      style: AppText.Body_bold.copyWith(color: Color(0xFFFE8400)),
                    ),
                  ),
                ],
              ),

              Text(
                'Join the competition now!',
                style: AppText.Body.copyWith(color: Color(0xFF6C6C6C)),
              ),
              
            ],
          ),
        ),

        // Gender Filter
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Obx(() => _buildGenderFilter()),
        ),

        const SizedBox(height: 20),

        // Class List
        Obx(() => SizedBox(
          height: 163,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: controller.filteredClasses.length,
            itemBuilder: (context, index) {
              final classItem = controller.filteredClasses[index];
              return _buildClassCard(
                title: classItem['title'],
                date: classItem['date'],
                gender: classItem['gender'],
                image: classItem['image'],
              );
            },
          ),
        )),
      ],
    );
  }

  // Gender Filter
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
                color: isSelected ? Color(0xFF0B0C4F) : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isSelected ? Color(0xFF0B0C4F) : Color(0xFF6C6C6C),
                  width: 1.5,
                ),
              ),
              child: Text(
                gender,
                style: AppText.Body.copyWith(
                  color: isSelected ? Colors.white : Color(0xFF000000),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // Class Card
  Widget _buildClassCard({
    required String title,
    required String date,
    required String gender,
    required String image,
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
            // Background
            Positioned.fill(
              child: Image.asset(
                image, 
                fit: BoxFit.cover
              ),
            ),

            // Overlay
            // Positioned.fill(
            //   child: Container(
            //     color: Colors.black.withOpacity(0.4),
            //   ),
            // ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        gender,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        date,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  Row(
                    children: [
                      // Title
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      const SizedBox(width: 28),

                      // Button
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          'See Details',
                          style: GoogleFonts.poppins(
                            color: AppColors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  )
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
        // Title
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Meet Our Judges',
                style: AppText.Heading2,
              ),
              SizedBox(height: 4),
              Text(
                'The true icons of Indonesia\'s bodybuilding',
                style: AppText.Body.copyWith(color: Color(0xFF6C6C6C)),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Judges List
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

  // Judge Card
  Widget _buildJudgeCard({
    required String name,
    required String description,
    required String image,
  }) {
    return Container(
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
            // Background
            Positioned.fill(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              )
            ),

            // Content
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 1),
                    // decoration: BoxDecoration(
                    //   border: Border(
                    //     bottom: BorderSide(
                    //       color: Color(0xFFFE8400),
                    //       width: 3,
                    //     ),
                    //   ),
                    // ),
                    child: Text(
                      name,
                      style: AppText.Subheading_Bold.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFFFE8400),
                        decorationThickness: 3,
                        color: Colors.white,
                      )
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: AppText.Body.copyWith(
                      color: AppColors.white,
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== Icon box ====================
  Widget _iconBox(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3), // semi transparan
        borderRadius: BorderRadius.circular(20), // lengkung
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 22,
      ),
    );
  }
}