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
      backgroundColor: Theme.of(context).colorScheme.background,
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
                    child: Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text('Cart', style: AppText.Heading2.copyWith(color: Theme.of(context).colorScheme.onBackground)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        'assets/icons/trash_icon.svg',
                        height: 26,
                        width: 26,
                        color: controller.cartItems.isEmpty ? Theme.of(context).colorScheme.onTertiary : Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20,),

            // ========================== CART LIST ========================== 
            
            Obx(() {
              if (controller.cartItems.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/cart_icon.svg',
                        height: 62,
                        width: 65,
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                      const SizedBox(height: 12,),
                      Text('There’s no product in your cart.', style: AppText.Subheading.copyWith(color: Theme.of(context).colorScheme.onTertiary),),
                    ],
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = controller.cartItems[index];
                      return _buildCartItem(item, context);
                    },
                    separatorBuilder: (_, __) => Divider(
                      height: 1,
                      thickness: 1,
                      color: Theme.of(context).dividerColor,
                      indent: 16,
                      endIndent: 16,
                    ), 
                    itemCount: controller.cartItems.length,
                  ),
                ),
              );
            }),

            const Spacer(),

            // ========================== BOTTOM BAR ========================== 
            Obx(() => controller.cartItems.isEmpty ? const SizedBox.shrink() : _buildBottomBar(context)),
          ],
        ),
      ),
    );
  }

  // ========================== CART ITEM ========================== 
  Widget _buildCartItem(Map<String, dynamic> item, BuildContext context) {
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
                  color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
                    width: 1,
                  ),
                ),
                child: isSelected
                    ? Icon(Icons.check, color: Theme.of(context).colorScheme.onPrimary, size: 14)
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
                      style: AppText.Body.copyWith(color: Theme.of(context).colorScheme.onBackground),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['pricelabel'] as String,
                      style: AppText.Subheading_Bold.copyWith(color: Theme.of(context).colorScheme.onBackground),
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
  Widget _buildBottomBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 12, 20, 30),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Total Price
          Text(
            controller.totalPriceLabel,
            style: AppText.Subheading_Bold.copyWith(color: Theme.of(context).colorScheme.onBackground)
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
