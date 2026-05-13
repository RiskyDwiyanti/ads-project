import 'package:fitpall/app/theme/app_colors.dart';
import 'package:fitpall/app/theme/app_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/scoring_controller.dart';

class ScoringView extends GetView<ScoringController> {
  const ScoringView({super.key});
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ========================== HEADER ==========================
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 62, 0, 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.arrow_back,
                        size: 24,
                        color:
                            Theme.of(context).colorScheme.onBackground,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Text(
                        args['title'] ?? 'Scoring',
                        style: AppText.Heading2.copyWith(
                          color:
                              Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ========================== GYM CARD ==========================
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(
                        'assets/image/gym1.png',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'GymFit Malang: Jl. A. Yani',
                            style: AppText.Body_bold.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            'Malang • 6km',
                            style: AppText.Body.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Icon(
                      Icons.chevron_right,
                      color:
                          Theme.of(context).colorScheme.onBackground,
                      size: 30,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ========================== PARTICIPANT HEADER ==========================
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Participant: 2/42',
                    style: AppText.Subheading_Bold.copyWith(
                      color:
                          Theme.of(context).colorScheme.onBackground,
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.sync,
                          color: AppColors.white,
                        ),

                        const SizedBox(width: 8),

                        Text(
                          'Sync',
                          style: AppText.Body.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ========================== PARTICIPANT LIST ==========================
              Expanded(
                child: GridView.builder(
                  itemCount: controller.participants.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    final item =
                        controller.participants[index];

                    final id = item['id'] as int;

                    return Obx(() {
                      final isSelected = controller.selectedPaticipant.containsKey(id);

                      return GestureDetector(
                        onTap: () =>
                            controller.toggleParticipant(id),
                        child: Stack(
                          children: [
                            // IMAGE
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: AssetImage(
                                    item['image'].toString(),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            // OVERLAY
                            if (isSelected)
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xCCB86B00),
                                  borderRadius:
                                      BorderRadius.circular(20),
                                ),
                              ),

                            // CHECK ICON
                            if (isSelected)
                              const Center(
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 60,
                                ),
                              ),

                            // CONTENT
                            Positioned(
                              left: 14,
                              right: 14,
                              bottom: 14,
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '#${index + 1}',
                                    style:
                                        AppText.Heading2.copyWith(
                                      color: AppColors.white,
                                    ),
                                  ),

                                  Text(
                                    item['name'].toString(),
                                    style: AppText
                                        .Subheading_Bold
                                        .copyWith(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      );
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
