import 'package:flutter/material.dart';

class SkillBuddyTypography {
  SkillBuddyTypography(this.color);
  factory SkillBuddyTypography.fromColor(Color color) {
    return SkillBuddyTypography(color);
  }
  final Color color;
//List of text styles
  TextStyle get kTitle => TextStyle(
        fontSize: 24,
        color: color,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        height: 1,
      );
  TextStyle get kParagraph => TextStyle(
        fontSize: 14,
        color: color,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w400,
      );
  TextStyle get kParagraphSemiBold => TextStyle(
        fontSize: 14,
        color: color,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w600,
      );
  TextStyle get kTextAdditional => TextStyle(
        fontSize: 12,
        color: color,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w400,
      );
  TextStyle get kParagraphSemiBold20 => TextStyle(
        fontSize: 20,
        color: color,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w600,
      );
  TextStyle get kInter => TextStyle(
        fontSize: 16,
        color: color,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
      );
  TextStyle get kInterSmall => TextStyle(
        fontSize: 14,
        color: color,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      );
}
