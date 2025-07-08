import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../service/theme_service.dart';
import '../theme/color.dart';
import '../theme/theme.dart';
import '../theme/typography.dart';
import '../util/util.dart';

class SkillBuddyTextField extends StatelessWidget {
  const SkillBuddyTextField({
    super.key,
    this.hintText,
    this.title,
    this.obscureText = false,
    this.hasError = false,
    this.validator,
    this.suffixIcon,
    this.controller,
    this.hintColor = DarkColor.grey,
    this.onChanged,
    this.maxLines = 1,
    this.keyBoardType,
    this.showActionButtons = false,
    this.maxLength,
  });

  final int? maxLength;
  final String? hintText;
  final String? title;
  final bool obscureText;
  final bool hasError;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Color hintColor;
  final void Function(String)? onChanged;
  final int maxLines;
  final TextInputType? keyBoardType;
  final bool showActionButtons;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title != null)
          Text(
            title!,
            style: SkillBuddyTypography.fromColor(theme.graphite)
                .kParagraphSemiBold,
          )
        else
          Container(),
        if (title != null) Gap(getRelativeHeight(4)),
        TextFormField(
          maxLength: maxLength,
          controller: controller,
          keyboardType: keyBoardType,
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
          maxLines: maxLines,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: TextStyle(color: hintColor),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: hasError ? theme.red : theme.electric,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: theme.red,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
