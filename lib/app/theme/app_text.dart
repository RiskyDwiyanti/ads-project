import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppText {
  static TextStyle Heading1 = GoogleFonts.unbounded(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  static TextStyle Heading2 = GoogleFonts.unbounded(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  static TextStyle Subheading_Bold = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static TextStyle Subheading_Bold2 = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static TextStyle Subheading = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  static TextStyle Body_bold = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static TextStyle Body = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  static TextStyle Body2_bold = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static TextStyle Body2 = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );
}