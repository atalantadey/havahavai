import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:havahavai/core/constants/app_colours.dart';

class AppStyles {
  static final titleStyle = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  static final subtitleStyle = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.textSecondary,
  );
  static final priceStyle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.accent,
  );
  static final strikethroughPriceStyle = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.textSecondary,
    decoration: TextDecoration.lineThrough,
  );
  static final discountStyle = GoogleFonts.poppins(
    fontSize: 12,
    color: AppColors.accent,
    fontWeight: FontWeight.bold,
  ); // Removed backgroundColor
  static final carouselPriceStyle = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
