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
      backgroundColor: Theme.of(context).colorScheme.background,
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
                    child: Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text('Notification', style: AppText.Heading2.copyWith(color: Theme.of(context).colorScheme.onBackground)),
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
                        child: Text(groupLabel, style: AppText.Subheading_Bold.copyWith(color: Theme.of(context).colorScheme.onBackground)),
                      ),

                      // Notification card 
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: List.generate(items.length, (index) {
                            final item = items[index];
                            final isLast = index == items.length - 1;
                            return _buildNotificationItem(item, isLast, context);
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
  Widget _buildNotificationItem(Map<String, dynamic> item, bool isLast, BuildContext context){
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
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onBackground,
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
                      style: AppText.Body_bold.copyWith(color: Theme.of(context).colorScheme.onBackground)
                    ),

                    const SizedBox(height: 4,),

                    Text(
                      item['message'] as String,
                      style: AppText.Body.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
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
                  color: Theme.of(context).colorScheme.onTertiary,
                ),
              ),
            ],
          ),
        ),

        // Divider kecuali item terakhir
        if (!isLast)
          Divider(
            height: 1,
            thickness: 1,
            color: Theme.of(context).dividerColor,
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }
}
