import 'package:fitpall/app/theme/app_colors.dart';
import 'package:fitpall/app/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
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
                  Text('Cart', style: AppText.Heading2),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        'assets/icons/trash_icon.svg',
                        height: 26,
                        width: 26,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20,),

            // ========================== CART LIST ========================== 
            Expanded(
              child: Obx(() {
                if (controller.cartItems.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/cart_icon.svg',
                          height: 62,
                          width: 65,
                        ),
                        const SizedBox(height: 12,),
                        Text('There’s no product in your cart.', style: AppText.Subheading.copyWith(color: AppColors.grey),),
                      ],
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = controller.cartItems[index];
                        return _buildCartItem(item);
                      },
                      separatorBuilder: (_, __) => const Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xFFF0F0F0),
                        indent: 16,
                        endIndent: 16,
                      ), 
                      itemCount: controller.cartItems.length,
                    ),
                  ),
                );
              }),
            ),

            // ========================== BOTTOM BAR ========================== 
            Obx(() => _buildBottomBar()),
          ],
        ),
      ),
    );
  }

  // ========================== CART ITEM ========================== 
  Widget _buildCartItem(Map<String, dynamic> item) {
    return Obx(() {
      final isSelected = controller.isSelected(item['id'] as String);
      
      return GestureDetector(
        onTap: () => controller.toggleItem(item['id'] as String),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              // Checkbox
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 21,
                height: 21,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColors.secondary : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? AppColors.secondary : AppColors.black,
                    width: 1,
                  ),
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.white, size: 14)
                    : null,
              ),

              const SizedBox(width: 14),
              
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  item['image'] as String,
                  width: 110,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 80,
                    height: 60,
                    color: const Color(0xFFEEEEEE),
                    child: const Icon(Icons.fitness_center, color: Color(0xFFAAAAAA)),
                  ),
                ),
              ),

              const SizedBox(width: 24),

              // Title & Price
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] as String,
                      style: AppText.Body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['pricelabel'] as String,
                      style: AppText.Subheading_Bold
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // // ========================== BOTTOM BAR ========================== 
  Widget _buildBottomBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.borderColor,
          width: 2,
        )
      ),
      child: Row(
        children: [
          // Total Price
          Text(
            controller.totalPriceLabel,
            style: AppText.Subheading_Bold
          ),

          const Spacer(),

          // Checkout button
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                'Check Out',
                style: AppText.Subheading_Bold.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
