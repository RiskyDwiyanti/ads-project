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
      backgroundColor: Theme.of(context).colorScheme.background,
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
                    child: Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text("faqs".tr, style: AppText.Heading2.copyWith(color: Theme.of(context).colorScheme.onBackground)),
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
                    color: Theme.of(context).cardColor,
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
                        context: context,
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
    required BuildContext context,
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
                        question.toString().tr,
                        style: AppText.Body_bold.copyWith(color: Theme.of(context).colorScheme.onBackground),
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
                        color: Theme.of(context).colorScheme.onBackground,
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
                      style: AppText.Body.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ), 
                ),
              ],
            ),
          ),
        ),

        // Divider 
        if (!isLast)
          Divider(
            height: 1,
            thickness: 1,
            color: Theme.of(context).dividerColor,
          )
      ],
    );
  }
}
