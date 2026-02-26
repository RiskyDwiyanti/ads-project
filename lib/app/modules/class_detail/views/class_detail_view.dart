import 'package:fitpall/app/theme/app_colors.dart';
import 'package:fitpall/app/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controllers/class_detail_controller.dart';

class ClassDetailView extends GetView<ClassDetailController> {
  const ClassDetailView({super.key});
  
  @override
  Widget build(BuildContext context) {
    final data = controller.classData;
    
    print('Building ClassDetailView with data: $data');

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ========== IMAGE HEADER SECTION ==========
          Stack(
            children: [
              // Background Image
              Container(
                height: 350,
                width: double.infinity,
                color: Colors.grey.shade900,
                child: data['image'] != null
                  ? Image.asset(
                      data['image']!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print('Image load error: $error');
                        return Container(
                          color: Colors.grey.shade900,
                          child: Icon(
                            Icons.fitness_center,
                            size: 100,
                            color: Colors.white.withOpacity(0.3),
                          ),
                        );
                      },
                    )
                  : Icon(
                      Icons.fitness_center,
                      size: 100,
                      color: Colors.white.withOpacity(0.3),
                    ),
              ),

              // Back Button & Details
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 62, 16, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Details',
                        style: AppText.Heading2.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Title & Price at Bottom
              Positioned(
                left: 24,
                right: 24,
                bottom: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['title']?.toString() ?? '/',
                      style: AppText.Subheading_Bold.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Rp. ${data['price']?.toString() ?? '/'}", // Hardcode dulu untuk testing
                      style: AppText.Heading1.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // ========== WHITE CONTENT SECTION ==========
          Expanded(
            child: Stack(
              children: [
                // White Container dengan Rounded Top
                Container(
                  transform: Matrix4.translationValues(0, -30, 0),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24),

                        // Info Row
                        _buildInfoRow(
                          category: data['gender']?.toString() ?? '/',
                          date: data['date']?.toString() ?? '/',
                          time: data['time']?.toString() ?? '/',
                        ),

                        SizedBox(height: 24),

                        // Location Card
                        _buildLocationCard(
                          location: 'GymFit Malang',
                          locationDetail: 'Malang • 6km',
                        ),

                        SizedBox(height: 32),

                        // Requirements
                        _buildRequirements(),
                      ],
                    ),
                  ),
                ),

                // Bottom Buttons
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.2), 
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 56,
                          width: 56,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.black,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/cart_icon.svg', // Sesuaikan path icon cart Anda
                              width: 24,
                              height: 24,
                              errorBuilder: (context, error, stackTrace) {
                                // Fallback jika icon tidak ada
                                return Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.black,
                                  size: 24,
                                );
                              },
                            ),
                          ),
                        ),

                        SizedBox(width: 16),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              print('Book button pressed');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFE8400),
                              padding: EdgeInsets.symmetric(vertical: 22, horizontal: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Book this Class',
                              style: AppText.Subheading_Bold.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required String category,
    required String date,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  'Category', 
                  style: AppText.Body
                ),
                SizedBox(height: 4),
                Text(
                  category, 
                  style: AppText.Body_bold
                ),
              ],
            ),
          ),
          Container(height: 40, width: 1, color: Color(0xFF6C6C6C).withOpacity(0.5)),
          Expanded(
            child: Column(
              children: [
                Text(
                  'Date', 
                  style: AppText.Body
                ),
                SizedBox(height: 4),
                Text(date, style: AppText.Body_bold),
              ],
            ),
          ),
          Container(height: 40, width: 1, color: Color(0xFF6C6C6C)),
          Expanded(
            child: Column(
              children: [
                Text('Time', style: AppText.Body),
                SizedBox(height: 4),
                Text(time, style: AppText.Body_bold),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard({
    required String location,
    required String locationDetail,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200, width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.location_city, color: Colors.grey.shade400, size: 30),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(location, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(locationDetail, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey.shade400, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirements() {
    final requirements = [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
      'Xcepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Requirements', style: AppText.Subheading_Bold),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.fromLTRB(26, 20, 20, 20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...requirements.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${entry.key + 1}. ', style: AppText.Body),
                        Expanded(child: Text(entry.value, style: AppText.Body)),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          )
        ],
      ),
    );
  }
}