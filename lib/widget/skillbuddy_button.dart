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
          style: textStyle ??
              SkillBuddyTypography(locked ? theme.graphite : theme.graphite)
                  .kParagraphSemiBold,
          maxLines: 1,
        );

    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: loading.value || locked
            ? null
            : () async {
                if (onTap != null) {
                  loading.value = true;
                  await onTap!.call();
                  loading.value = false;
                }
              },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                if (locked) theme.slate else color ?? theme.electric,
                if (locked)
                  theme.fadedGreen
                else
                  color ?? const Color.fromRGBO(46, 14, 88, 1),
              ],
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.all(padding * 1.8),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (leading != null) ...<Widget>[
                  leading!,
                  const SizedBox(width: 8),
                ],
                if (loading.value) const Gap(4),
                if (loading.value)
                  const SizedBox(
                    height: 16,
                    width: 16,
                  ),
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
