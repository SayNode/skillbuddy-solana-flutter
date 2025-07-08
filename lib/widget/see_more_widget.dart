import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/theme_service.dart';

class SeeMoreWidget extends GetView<SeeMoreController> {
  const SeeMoreWidget({
    required this.text,
    super.key,
    this.maxLines = 3,
    this.style,
  });

  final String text;
  final int maxLines;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    Get.put(SeeMoreController());
    return Obx(() {
      final DefaultTextStyle defaultContextStyle = DefaultTextStyle.of(context);
      TextStyle? textStyle = style;
      if (style == null || style!.inherit) {
        textStyle = defaultContextStyle.style.merge(style);
      }

      final TextSpan expandText = TextSpan(
        children: <InlineSpan>[
          TextSpan(
            style: textStyle,
            children: <TextSpan>[
              TextSpan(
                text: controller.expanded.value ? '' : '... ',
                style: textStyle,
              ),
              TextSpan(
                text: controller.expanded.value ? ' less'.tr : 'more'.tr,
                style: textStyle!.copyWith(
                  color: ThemeService().theme.electric,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      );

      final TextSpan content = TextSpan(
        children: <TextSpan>[TextSpan(text: text.tr)],
        style: textStyle,
      );

      final Widget result = LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          assert(
            constraints.hasBoundedWidth,
            'SeeMoreWidget must have a bounded width'.tr,
          );
          final double maxWidth = constraints.maxWidth;

          final TextPainter textPainter = TextPainter(
            text: expandText,
            textDirection: Directionality.of(context),
            textScaler: MediaQuery.textScalerOf(context),
            maxLines: maxLines,
          )..layout(
              minWidth: constraints.minWidth,
              maxWidth: maxWidth,
            );
          final Size expandTextSize = textPainter.size;

          textPainter
            ..text = content
            ..layout(
              minWidth: constraints.minWidth,
              maxWidth: maxWidth,
            );
          final Size textSize = textPainter.size;

          TextSpan textSpan;
          if (textPainter.didExceedMaxLines) {
            final TextPosition position = textPainter.getPositionForOffset(
              Offset(
                textSize.width - expandTextSize.width,
                textSize.height,
              ),
            );

            final TextSpan text = TextSpan(
              text: controller.expanded.value
                  ? this.text.tr
                  : this
                      .text
                      .substring(
                        0,
                        max(
                          textPainter.getOffsetBefore(position.offset) ?? 0,
                          0,
                        ),
                      )
                      .tr,
            );

            textSpan = TextSpan(
              style: textStyle,
              children: <TextSpan>[
                text,
                expandText,
              ],
            );
          } else {
            textSpan = content;
          }

          final RichText richText = RichText(
            text: textSpan,
            textDirection: Directionality.of(context),
            textScaler: MediaQuery.textScalerOf(context),
          );

          return richText;
        },
      );

      return GestureDetector(onTap: controller.expanded.toggle, child: result);
    });
  }
}

class SeeMoreController extends GetxController {
  RxBool expanded = false.obs;
}
