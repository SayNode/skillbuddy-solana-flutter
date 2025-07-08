import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/theme_service.dart';
import '../theme/theme.dart';
import '../theme/typography.dart';
import '../util/util.dart';

class CodeInputField extends StatelessWidget {
  const CodeInputField({
    required this.focusNode,
    required this.nextFocusNode,
    super.key,
    this.controller,
  });
  final TextEditingController? controller;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getRelativeWidth(10),
      ),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        child: SizedBox(
          width: getRelativeWidth(70),
          height: getRelativeHeight(70),
          child: TextField(
            maxLength: 1,
            controller: controller,
            textAlign: TextAlign.center,
            style: SkillBuddyTypography.fromColor(
              theme.graphite,
            ).kTitle,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              counterText: '',
            ),
            focusNode: focusNode,
            onChanged: (String value) {
              if (value.isNotEmpty) {
                focusNode.unfocus();
                FocusScope.of(context).requestFocus(nextFocusNode);
              }
            },
          ),
        ),
      ),
    );
  }
}
