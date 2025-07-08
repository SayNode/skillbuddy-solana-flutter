import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/theme_service.dart';
import '../theme/theme.dart';

class SkillBuddyChip extends StatelessWidget {
  const SkillBuddyChip({
    required this.child,
    super.key,
    this.onTap,
    this.borderRadius = 6,
    this.selected = false,
  });

  final Widget child;
  final void Function()? onTap;
  final bool selected;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide(color: selected ? theme.electric : theme.grey),
      ),
      color: selected ? theme.seashell : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: child,
      ),
    );
  }
}
