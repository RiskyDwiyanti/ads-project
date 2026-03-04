import 'package:fitpall/app/theme/app_colors.dart';
import 'package:fitpall/app/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ========================== HEADER ========================== 
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 62, 20, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text('Notification', style: AppText.Heading2),
                ],
              ),
            ),

            const SizedBox(height: 20,),

            // ========================== CONTENT ==========================  
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                itemCount: controller.notifications.keys.length,
                itemBuilder: (context, groupIndex) {
                  final groupLabel = controller.notifications.keys.elementAt(groupIndex);
                  final items = controller.notifications[groupLabel]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Group label
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(groupLabel, style: AppText.Subheading_Bold,),
                      ),

                      // Notification card 
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: List.generate(items.length, (index) {
                            final item = items[index];
                            final isLast = index == items.length - 1;
                            return _buildNotificationItem(item, isLast);
                          }),
                        ),
                      ),

                      const SizedBox(height: 24,),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================== NOTIFICATION ITEM ============================== 
  Widget _buildNotificationItem(Map<String, dynamic> item, bool isLast){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // icon
              SvgPicture.asset(
                item['icon'] as String,
                width: 24,
                height: 27,
                colorFilter: const ColorFilter.mode(
                  AppColors.black,
                  BlendMode.srcIn,
                ),
              ),

              const SizedBox(width: 24,),

              // Title & Message
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] as String,
                      style: AppText.Body_bold
                    ),

                    const SizedBox(height: 4,),

                    Text(
                      item['message'] as String,
                      style: AppText.Body.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12,),

              // Time
              Text(
                item['time'] as String,
                style: AppText.Body.copyWith(
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ),

        // Divider kecuali item terakhir
        if (!isLast)
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF0F0F0),
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }
}
