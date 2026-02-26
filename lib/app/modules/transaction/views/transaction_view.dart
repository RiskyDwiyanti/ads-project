import 'package:fitpall/app/theme/app_colors.dart';
import 'package:fitpall/app/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================== HEADER ====================
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 52, 20, 20),
              child: Text(
                'Transaction',
                style: AppText.Heading1,
              ),
            ),

            const SizedBox(height: 20),

            // ==================== FILTER ====================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() => _buildFilterRow()),
            ),

            const SizedBox(height: 32),

            // ==================== TRANSACTION LIST ====================
            Expanded(
              child: Obx(() {
                final grouped = controller.groupedTransactions;

                if (grouped.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.receipt_long_outlined, size: 60, color: Colors.grey.shade300),
                        const SizedBox(height: 12),
                        Text(
                          'No transactions found',
                          style: AppText.Body.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                  itemCount: grouped.keys.length,
                  itemBuilder: (context, groupIndex) {
                    final date = grouped.keys.elementAt(groupIndex);
                    final transactions = grouped[date]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date Header
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            date,
                            style: AppText.Heading2,
                          ),
                        ),

                        // Transaction Card (grouped per tanggal)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: List.generate(transactions.length, (index) {
                              final tx = transactions[index];
                              final isLast = index == transactions.length - 1;
                              return _buildTransactionItem(tx, isLast);
                            }),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== FILTER ROW ====================
  Widget _buildFilterRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: controller.filters.map((filter) {
          final isSelected = controller.selectedFilter.value == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => controller.selectFilter(filter),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.secondary : AppColors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: isSelected ? AppColors.secondary : const Color(0xFF6C6C6C),
                    width: 1,
                  ),
                ),
                child: Text(
                  filter,
                  style: AppText.Body.copyWith(
                    color: isSelected ? AppColors.white : AppColors.black,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ==================== TRANSACTION ITEM ====================
  Widget _buildTransactionItem(Map<String, dynamic> tx, bool isLast) {
    final status = tx['status'] as String;

    Color statusColor;
    switch (status) {
      case 'Paid':
        statusColor = AppColors.primary;
        break;
      case 'Canceled':
        statusColor = const Color(0xFFFF3D00);
        break;
      case 'Unpaid':
        statusColor = const Color(0xFF9E9E9E);
        break;
      default:
        statusColor = const Color(0xFF9E9E9E);
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              // Icon
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SvgPicture.asset(
                  'assets/icons/recipt_icon.svg',
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    AppColors.secondary, 
                    BlendMode.srcIn
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Title & Price
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx['title'],
                      style: AppText.Body_bold.copyWith(color: const Color(0xFF1A1A1A)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      tx['price'],
                      style: AppText.Body.copyWith(color: const Color(0xFF6C6C6C)),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Status & Icon
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    status,
                    style: AppText.Body_bold.copyWith(color: statusColor),
                  ),
                  const SizedBox(height: 4),
                  SvgPicture.asset(
                    'assets/icons/gopay_icon.svg',
                    width: 22,
                    height: 22,
                    colorFilter: ColorFilter.mode(
                      Color(0xFF00ABD6), 
                      BlendMode.srcIn
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Divider (kecuali item terakhir)
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
