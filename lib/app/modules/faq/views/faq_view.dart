import 'package:fitpall/app/theme/app_colors.dart';
import 'package:fitpall/app/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/faq_controller.dart';

class FaqView extends GetView<FaqController> {
  const FaqView({super.key});
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
              padding: const EdgeInsets.fromLTRB(20, 62, 20, 20),
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
                  Text('FAQs', style: AppText.Heading2),
                  const Spacer(),
                ],
              ),
            ),

            // ========================== FAQ LIST ========================== 
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Obx(() => Column(
                    children: List.generate(controller.faqs.length, (index) {
                      final faq = controller.faqs[index];
                      final islast = index == controller.faqs.length - 1;
                      return _buildFaqItem(
                        index: index,
                        question: faq['question']!,
                        answer: faq['answer']!,
                        isLast: islast,
                      );
                    }) ,
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem({
    required int index,
    required String question,
    required String answer,
    required bool isLast,
  }) {
    final isOpen = controller.isOpen(index);

    return Column(
      children: [
        GestureDetector(
          onTap: () => controller.toggleFaq(index),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Question row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        question,
                        style: AppText.Body_bold,
                      ), 
                    ),
                    const SizedBox(width: 12,),
                    AnimatedRotation(
                      turns: isOpen ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: SvgPicture.asset(
                        'assets/icons/arrow_icon.svg',
                        height: 6,
                        width: 12,
                      ),
                    ),
                  ],
                ),
                // Answer
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  crossFadeState: isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 250),
                  secondChild: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      answer,
                      style: AppText.Body,
                    ),
                  ), 
                ),
              ],
            ),
          ),
        ),

        // Divider 
        if (!isLast)
          const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.white,
          )
      ],
    );
  }
}
