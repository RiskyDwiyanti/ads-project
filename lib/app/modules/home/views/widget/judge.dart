import 'package:fitpall/app/theme/app_colors.dart';
import 'package:fitpall/app/theme/app_text.dart';
import 'package:flutter/material.dart';

class JudgeDetailDialog extends StatelessWidget {
  final String name;
  final String description;
  final String image;

  const JudgeDetailDialog({
    super.key,
    required this.name,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              constraints: const BoxConstraints(maxWidth: 330),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image
                  Container(
                    height: 270,
                    width: 330,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Stack(
                        children: [
                          // Image
                          Positioned.fill(
                            child: image != null
                              ? Image.asset(
                                  image,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey.shade900,
                                      child: Icon(
                                        Icons.person,
                                        size: 100,
                                        color: Colors.white.withOpacity(0.3),
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  color: Colors.grey.shade900,
                                  child: Icon(
                                    Icons.person,
                                    size: 100,
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 84, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: AppText.Heading2.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primary,
                            decorationThickness: 3,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description,
                          style: AppText.Body
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: AppText.Body
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}