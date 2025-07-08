import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../service/theme_service.dart';
import '../theme/theme.dart';
import '../theme/typography.dart';

class SkillBuddyButton extends StatelessWidget {
  SkillBuddyButton({
    required this.text,
    required this.onTap,
    super.key,
    this.color,
    this.textColor,
    this.leading,
    this.trailing,
    this.textStyle,
    this.locked = false,
    this.height,
    this.borderRadius = 12,
    this.padding = 12,
  });

  final String text;
  final Color? color;
  final dynamic Function()? onTap;
  final Color? textColor;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? textStyle;
  final bool locked;
  final double? height;
  final double borderRadius;
  final double padding;

  final RxBool loading = false.obs;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;

    Text getText() => Text(
          text,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style:
              textStyle ?? SkillBuddyTypography(theme.linen).kParagraphSemiBold,
          maxLines: 1,
        );

    return SizedBox(
      height: height,
      width:
          double.infinity, // Make the button expand to fill the available width
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(padding),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: locked ? theme.grey : (color ?? theme.graphite),
          disabledBackgroundColor:
              locked ? theme.grey : (color ?? theme.graphite),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: loading.value || locked
            ? null
            : () async {
                if (onTap != null) {
                  loading.value = true;
                  await onTap!.call();
                  loading.value = false;
                }
              },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the content
              children: <Widget>[
                if (leading != null) ...<Widget>[
                  leading!,
                  const SizedBox(width: 8), // Adjust spacing as needed
                ],
                if (loading.value) const Gap(4),
                if (loading.value)
                  const SizedBox(
                    height: 16,
                    width: 16,
                  ),
                // Remove the Expanded widget around getText()
                getText(),
                if (loading.value) const Gap(4),
                if (loading.value)
                  const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      color: Colors.white,
                    ),
                  )
                else
                  const SizedBox.shrink(),
                if (trailing != null) ...<Widget>[
                  const SizedBox(width: 8),
                  trailing!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
